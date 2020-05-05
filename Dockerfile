FROM centos:7

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install git make autoconf curl wget vim
RUN yum -y install -y gcc-c++ openssl-devel readline-devel zlib-devel bzip2 gcc sqlite-devel
RUN yum -y install -y postgresql-devel
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash - ; yum -y install nodejs

# IUS Community Project のリポジトリを追加する
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
# Python3.6をインストール
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip

# virtualenvをインストール
RUN pip3 install virtualenv
# 作業ディレクトリの作成、設定
RUN mkdir djangogirls
# 作業ディレクトリ名をDJANGO_GIRLSに割り当てて、以下$DJANGO_GIRLSで参照
ENV DJANGO_GIRLS /djangogirls
WORKDIR $DJANGO_GIRLS
# virtualenvで仮想環境を作成する
RUN python3 -m virtualenv $DJANGO_GIRLS/myvenv

# ホスト側（ローカル）のrequirements.txtを追加する
COPY ./requirements.txt $DJANGO_GIRLS/requirements.txt
# 仮想環境を起動し、Djangoをインストール
RUN source $DJANGO_GIRLS/myvenv/bin/activate; pip install -r requirements.txt
