# Docker
## Official
https://www.docker.com/
## GCP
https://cloud.google.com/container-engine/?hl=ja
## AWS
https://aws.amazon.com/jp/ecs/

# About
2つのブランチ "7.0", "5.6"はそれぞれのPHPのバージョンを、docker-composeを利用して、開発環境として実行することを想定しています。
そのため、本番環境では不要となるMySQLコンテナ,Redisコンテナを含みます。

# Dockerがもたらすもの
本番環境としてDockerを運用した場合、ホストOSに必要なものはDocker実行環境のみです。
これにより、煩雑なAMIの管理をする必要はほぼ無くなります。
また、ECSやkubernetesなどのオーケストレーションツールを使用することにより、
アプリケーションのデプロイを簡素化します。
開発者、インフラ担当者が管理するものは、Dockerイメージのみです。

# 今の環境の問題点(と思われるもの)
パッケージのソースインストールは特別な理由が無ければ避けたほうが良いです。
これは、イメージを作成するDockerfileの記述が一種の職人芸になりがちであり、
長期的な運用を想定した場合は現実的ではなくなってしまうためです。
