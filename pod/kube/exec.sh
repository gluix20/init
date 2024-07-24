#!/bin/bash

kubectl exec -it -n af-user-jobs dbt-mortgage-map-test -- bash

# kubectl exec -it -n af-user-jobs dbt-mortgage-map-test -- /usr/src/app/entrypoint.sh bash -c 'cd projects/event_pipelines && ./run_backtest.sh'
