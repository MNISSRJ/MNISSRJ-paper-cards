# 纸卡移动版

项目现在可作为 PWA 安装，也保留了 Android 和 iOS 的原生壳打包配置，并支持邮箱账号跨设备同步。

## 启用账号与跨设备同步

1. 创建一个 [Supabase](https://supabase.com/) 项目，在 **SQL Editor** 执行 [supabase-schema.sql](./supabase-schema.sql) 的内容。
2. 在 **Authentication → Providers** 启用 Email；生产环境建议启用邮箱确认。
3. 在 **Project Settings → API** 复制 `Project URL` 与 `anon public` key，填入 [cloud-config.js](./cloud-config.js)。**绝不能使用 `service_role` key。**
4. 重新部署应用。用户可在右上角“登录同步”注册邮箱账号；首次登录若云端已有数据，会由用户决定下载云端数据或保留并上传本机数据。

表启用了行级安全策略，登录用户只能读取和改写自己的卡片。数据传输由 Supabase HTTPS 保护；密码由 Supabase Auth 处理，应用不保存明文密码。

## 直接安装（推荐）

将此目录部署到任意 HTTPS 静态网站后，在手机浏览器打开：

- Android Chrome：浏览器菜单选择“安装应用”，或使用页面顶部的“安装应用”按钮。
- iPhone/iPad Safari：点“分享”→“添加到主屏幕”。

首次打开会缓存应用页面；后续可离线学习。学习数据仅保存在当前设备，请通过“导出备份”定期保存，手机上会优先唤起系统分享。

## 打包原生 Android / iOS

需要 Node.js 20+；iOS 构建还需要一台安装 Xcode 的 macOS 电脑。

```powershell
npm install
npm run android:add
npm run sync:native
npm run android:open
```

Android Studio 中选择 Build → Generate Signed Bundle / APK 即可生成安装包。iOS 请在 macOS 上运行 `npm run ios:add`、`npm run sync:native`、`npm run ios:open`，然后使用 Xcode Archive 发布。

## 此次移动端优化

- 安装提示、独立应用窗口和离线缓存。
- 备份在手机上优先使用系统分享，可直接保存到文件或发送给自己。
- 导入内容增加结构、日期和空卡过滤，避免错误备份破坏本地数据。
- 保留拍照 OCR、间隔复习、批量导入、学习打卡和数据备份。
