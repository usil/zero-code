workspaces_path=$(pwd)

function delete_image_if_exist {
  image=$(docker images "$1" -a -q)
  if [ ! "$image" == "" ]; then
    echo "deleting image: $image"
    docker rmi -f "$image"
  fi
}

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done

echo "#################"
echo "Updating source code"
echo "#################"

cd $workspaces_path/zero-code-ui
git fetch
latest_branch=$(git for-each-ref --sort=-committerdate | head -n 1 | awk -F '/' '{ print $NF }')
git checkout $latest_branch
git pull origin $latest_branch

cd $workspaces_path/zero-code-api
git fetch
latest_branch=$(git for-each-ref --sort=-committerdate | head -n 1 | awk -F '/' '{ print $NF }')
git checkout $latest_branch
git pull origin $latest_branch


echo "#################"
echo "Launching"
echo "#################"
cd $workspaces_path

export JWT_SECRET=$(uuidgen)
export CRYPTO_KEY=$(uuidgen)
export MYSQL_PASSWORD=$(uuidgen)

if [ ! -f .env ]; then
  echo "" > .env
else
  echo ".env file already exist"
  cat .env
  export $(cat .env | xargs)
fi

if [[ -z "$ZERO_CODE_API_PORT" ]]
then
  echo "Enter ZERO_CODE_API_PORT: (2111) "
  read _ZERO_CODE_API_PORT
  export ZERO_CODE_API_PORT=$_ZERO_CODE_API_PORT
  echo "ZERO_CODE_API_PORT=$ZERO_CODE_API_PORT" >> .env
fi

if [[ -z "$ZERO_CODE_UI_PORT" ]]
then
  echo "Enter ZERO_CODE_UI_PORT: (2112)"
  read _ZERO_CODE_UI_PORT
  export ZERO_CODE_UI_PORT=$_ZERO_CODE_UI_PORT
  echo "ZERO_CODE_UI_PORT=$ZERO_CODE_UI_PORT" >> .env
fi

if [[ -z "$ZERO_CODE_API_BASE_URL" ]]
then
  echo "Enter ZERO_CODE_API_BASE_URL: "
  read _ZERO_CODE_API_BASE_URL
  export ZERO_CODE_API_BASE_URL=$_ZERO_CODE_API_BASE_URL
  echo "ZERO_CODE_API_BASE_URL=$ZERO_CODE_API_BASE_URL" >> .env
fi

function delete_image_if_exist {
  image=$(docker images "$1" -a -q)
  if [ ! "$image" == "" ]; then
    echo "deleting image: $image"
    docker rmi -f "$image"
  fi
}

if [ "$build" == "true" ]; then
  delete_image_if_exist "zero_code_zero-code-ui"
  delete_image_if_exist "zero_code_zero-code-api"
  docker-compose down && docker-compose up -d --build
else
  docker-compose down && docker-compose up -d
fi
