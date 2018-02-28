folder('cloudera-access') {
    description('Folder for managing cloudera cluster users')
}

pipelineJob('cloudera-access/add-user') {

  def repo = 'https://github.com/gd-ikharlamov/gridu-jenkins'

  description('cloudera hadoop cluster access')

  definition {
    cpsScm {
      scm {
        git {
          remote { url(repo) }
          branches('master')
          scriptPath('jobs/cloudera-access-add-user-pipeline')
          extensions { }
        }
      }
    }
  }
}


pipelineJob('cloudera-access/remove-user') {

  def repo = 'https://github.com/gd-ikharlamov/gridu-jenkins'

  description('cloudera hadoop cluster access')

  parameters {
    stringParam('user_name','','Enter user name, eg: ikharlamov')
  }

  definition {
    cpsScm {
      scm {
        git {
          remote { url(repo) }
          branches('master')
          scriptPath('jobs/cloudera-access-remove-user-pipeline')
          extensions { }
        }
      }
    }
  }
}
