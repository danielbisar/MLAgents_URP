# MLAgents_URP
Example project for ML-Agents (incl. docker image for venv setup)

Just clone this repo and open it with Unity (currently 2022.3.11f1)

## Scripts

### build_mlagents_docker.sh

Creates/updates the mlagents docker image.
Notes
- this script deletes any existing container with the name: "mlagents"
  - remove --rm to keep the container
- the folder ./ml-agents-docker/home/src/venv is used for the python virtual environment
- the folder ./ml-agents-docker/home/src/ml-agents is used for the unity mlagents repo (symlink to ./submodules/ml-agents)

### run_mlagents_docker.sh

Creates/run existing mlagents container. You need to delete the container to trigger a rebuild.
