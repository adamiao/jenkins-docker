pipeline {
	agent any
    triggers {
		githubPush()
	}
	environment	{
		IMAGE_NAME="test-image"
		CONTAINER_NAME="test-container"
	}
	stages {
		stage('Build') {
			steps {
			sh '''
				echo "Check current working directory"
				pwd
				echo "Build docker image and run container"
				docker build -t $IMAGE_NAME .
			'''
			}
		}
		stage('Test') {
			steps {
			sh '''
				docker run -d --name $CONTAINER_NAME $IMAGE_NAME
				echo "Copy result.xml into Jenkins container"
				docker cp $CONTAINER_NAME:/my-application/result.xml result.xml
			'''
			}
		}
		stage('Cleanup') {
			steps {
			sh '''
				echo "Cleanup container and image"
				docker stop $CONTAINER_NAME
				docker rm $CONTAINER_NAME
				docker rmi $IMAGE_NAME
			'''
			}
		}
		stage('Deploy') {
			steps {
			echo "Deploy stage"
			}
		}
	}
    post { 
        always { 
            cleanWs()
        }
    }
}
