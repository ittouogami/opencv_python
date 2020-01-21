# OpenCV+Python

OpenCVです。

# Features

OpenCV&python3をjupyter notebook上で動かすことを想定しています。
OpenCVはビルドしていますのでイメージ作成には時間が掛かります。
pipに追記すればtensorflowなんかも動くかもしれません。
外部デバイスはUCVなカメラのみ考慮しています。
イメージを小さくする為に、debian busterのslimをベースにしています。
ホストのユーザID、グループID、カメラのgroupIDをそのまま使っています。
homeはホストの${HOME}/docker/userhome決め打ちででmountしています。
--privileged付けているのでセキュリティ無視です。

# Requirement

* docker-ce

# Installation

```
./build.sh
```

# Usage

```
./boot.sh
```

# Note

Ubuntu16,18,19にて動作確認

