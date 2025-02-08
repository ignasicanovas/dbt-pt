import os
from datetime import datetime
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn",
        profile_args={"database": "prop_db_dev", "schema": "pt"},
    )
)

# DAG separado para ejecutar full refresh
dbt_full_refresh_dag = DbtDag(
    project_config=ProjectConfig("/usr/local/airflow/dags/dbt/propwh"),
    operator_args={"install_deps": True, "full_refresh": True},  
    profile_config=profile_config,
    execution_config=ExecutionConfig(
        dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt"
    ),
    schedule_interval=None,  
    start_date=datetime(2025, 1, 1),
    catchup=False,
    dag_id="dbt_full_refresh_dag",
)
