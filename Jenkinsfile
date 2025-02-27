pipeline {
    agent any

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
                                    execCommand: """
                                    cd blog_app && \\
                                    sed -i 's/\r$//' entrypoint.sh && \\
                                    docker compose up -d --build --force-recreate --no-deps
                                    """
                                ) 
                            ], 
                            verbose: false
                        ) 
                    ])
                }
            }
        }
    }
}
