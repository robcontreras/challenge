node {
  def commit_id

  stage("Preparation") {
    checkout scm
    sh "git rev-parse --short HEAD > .git/commit-d"
    commit_id = readFile('.git/commit-id').trim()
  }

  stage("Test") {
    sh 'docker-compose run --rm web bundle exec rspec'
  }
}