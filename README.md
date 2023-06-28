# MLAgents_URP
Example project for ML-Agents (incl. docker image for venv setup)

Just clone this repo and open it with Unity (currently 2022.2.21f1)

## Scripts

### build_mlagents_docker.sh

Creates/updates the mlagents docker image.
Notes
- this script deletes any existing container with the name: "mlagents"
- the folder ./Scripts/mount/venv is used for the python virtual environment (folder venv will be created)
- the folder ./Scripts/moutn/ml-agents is used for the unity mlagents repo

### run_mlagents_docker.sh

Creates/run existing mlagents container. You need to delete the container to trigger a rebuild.
Notes:
- if the folder ./Scripts/moutn/ml-agents it will be reused
- if the folder ./Scripts/mount/venv exist it will be removed and recreated

