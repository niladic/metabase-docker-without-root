# Metabase Docker image without using root user

This is a temporary solution to https://github.com/metabase/metabase/issues/9861

Base `Dockerfile`: https://github.com/metabase/metabase/blob/v0.36.4/bin/docker/Dockerfile

Base `ENTRYPOINT`: https://github.com/metabase/metabase/blob/v0.36.4/bin/docker/run_metabase.sh


Uses hard coded version `v0.36.4`.
