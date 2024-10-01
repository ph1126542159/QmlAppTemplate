#!/usr/bin/env bash

# 定义应用名称和版本
APP_NAME="QmlAppTemplate"
APP_VERSION=0.7
GIT_VERSION=$(git rev-parse --short HEAD)

echo "> $APP_NAME packager (Windows x86_64) [v$APP_VERSION]"

# 确保在正确的目录中运行
if [[ "${PWD##*/}" != "$APP_NAME" ]]; then
  echo "This script MUST be run from the $APP_NAME/ directory"
  exit 1
fi

# 初始化参数
use_contribs=false
make_install=false
create_package=false
upload_package=false

# 解析命令行参数
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--contribs) use_contribs=true ;;
    -i|--install) make_install=true ;;
    -p|--package) create_package=true ;;
    -u|--upload) upload_package=true ;;
    *) echo "> Unknown argument '$1'" ;;
  esac
  shift  # 移动到下一个参数
done

# 应用安装
if [[ $make_install == true ]]; then
  echo '---- Running make install'
  make INSTALL_ROOT=bin/ install
fi

# 部署应用程序
echo '---- Running windeployqt'
windeployqt bin/ --qmldir qml/

# 重命名输出目录
mv bin "$APP_NAME"

# 创建压缩包（ZIP）
if [[ $create_package == true ]]; then
  echo '---- Compressing package'
  7z a "$APP_NAME-$APP_VERSION-win64.zip" "$APP_NAME"
fi

# 创建安装程序（NSIS）
if [[ $create_package == true ]]; then
  echo '---- Creating installer'
  mv "$APP_NAME" assets/windows/"$APP_NAME"
  makensis assets/windows/setup.nsi
  mv assets/windows/*.exe "$APP_NAME-$APP_VERSION-win64.exe"
fi

# 上传到远程服务器
if [[ $upload_package == true ]]; then
  echo "---- Uploading to transfer.sh"
  curl --upload-file "$APP_NAME"*.zip "https://transfer.sh/$APP_NAME-$APP_VERSION-git$GIT_VERSION-win64.zip"
  curl --upload-file "$APP_NAME"*.exe "https://transfer.sh/$APP_NAME-$APP_VERSION-git$GIT_VERSION-win64.exe"
fi
