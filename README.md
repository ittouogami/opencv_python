# OpenCV+Python

OpenCVです。

# Features

OpenCV&python3をjupyter notebook上で動かすことを想定しています。
OpenCVはビルドしていますのでイメージ作成には時間が掛かります。
debian busterのslimをベースにしています。
pipに追記すればtensorflowなんかも動くかもしれません。
ホストのユーザID、グループID、カメラのグループIDをそのまま使っています。
外部デバイスはUCVなカメラのみ考慮しており、matploplibとnumpyは一応動いているっぽいです。動画がXVIDとMP4Vを確認しましたが、('M', 'P', '4', 'V')と指定すると何故か壊れたファイルが出力されます。(\*'MP4V')だと再生可能なファイルが吐き出されます。
homeはホストの${HOME}/docker/userhome決め打ちででmountしています。
--privileged付けているのでセキュリティ無視です(--device指定すれば良いんだと思いますが)。

# Requirement

```
docker-ce
```

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

