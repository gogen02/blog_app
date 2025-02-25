pipeline {
    agent any

    environment {
        ENABLE_VERBOSE = true
    }

    stages {
        stage('Клонирование репозитория') {
            steps {
                git branch: 'main', url: 'https://github.com/gogen02/blog_app.git'
            }
        }

        stage('Копирование файлов на сервер') { 
            steps { 
                script { 
                    sshPublisher(publishers: [ 
                        sshPublisherDesc(configName: "gruzdev", 
                            transfers: [ 
                                sshTransfer(
                                    sourceFiles: "**", 
                                    remoteDirectory: "/blog_app/",
                                    cleanRemote: true, 
                                    excludes: '*.log, *.lock, .svn/, .git/',
                                ) 
                            ], 
                            verbose: ${ENABLE_VERBOSE}
                        ) 
                    ])
                }
            }
        }

        stage('Запуск Docker Compose') { 
            steps { 
                script { 
                    sshPublisher(publishers: [ 
                        sshPublisherDesc(configName: "gruzdev", 
                            transfers: [
                                sshTransfer(
                                execCommand: """
                                cd blog_app && \\
                                docker-compose down && \\
                                docker-compose up -d --build
                                """
                                ) 
                           ],
                           verbose: ${ENABLE_VERBOSE}
                        )
                            
                    ]) 
                } 
            } 
        }
    }

    post {
        always {
            echo 'Pipeline завершен!'
        }
    }
}
