# hy通用package

pub中地址：https://pub.flutter-io.cn/packages/hy

运行 dry-run 命令以检验是否所有内容都通过了分析：

```bash
flutter pub publish --dry-run
```

发布，请注意：[发布是永久性](https://dart.cn/tools/pub/publishing#publishing-is-forever)的，运行以下提交命令：

```bash
flutter pub publish
```

如果设置了中国镜像即需要用如下命令提交：

```bash
flutter packages pub publish --server=https://pub.dartlang.org
```

连接pub服务器失败：

```bash
Authorization received, processing...
It looks like accounts.google.com is having some trouble.
Pub will wait for a while before trying to connect again.
OS Error: Operation timed out, errno = 60, address = accounts.google.com, port = 54374
pub finished with exit code 69
```

设置代理：
```bash
export https_proxy=http://127.0.0.1:1087
export http_proxy=http://127.0.0.1:1087
set https_proxy=https://127.0.0.1:1087
set http_proxy=http://127.0.0.1:1087
```