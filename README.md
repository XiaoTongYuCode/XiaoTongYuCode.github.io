# 肖彤宇个人主页与简历

零构建依赖的静态站点。`index.html` 是网页与 PDF 简历的唯一内容源：

- 屏幕端：响应式个人主页
- 打印端：两页 A4 简历
- PDF：`assets/xiaotongyu-resume.pdf`

## 本地预览

```bash
python3 -m http.server 8000
```

打开 `http://localhost:8000`。

## 重新生成 PDF

```bash
./scripts/build-pdf.sh
```

脚本使用 Chrome/Chromium 打印 `index.html`，并在存在 `pdfinfo` 时校验结果必须为两页。可通过 `CHROME_BIN` 指定浏览器可执行文件。
