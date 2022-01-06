#!/bin/bash
#设置环境变量
useVersionInfo=$(git show -s --date=short --format="编译前的最后一次[➦主源码](https://github.com/coolsnowwolf/lede)更新记录:<br/>更新人: %an<br/>更新时间: %cd<br/>更新内容: %s<br/>哈希值: %H")
echo "useVersionInfo=$useVersionInfo" >> $GITHUB_ENV
echo "DATE=$(date "+%Y年%m月%d日%H时%M分")" >> $GITHUB_ENV
echo "DATE1=$(date "+%Y.%m.%d")" >> $GITHUB_ENV
# 修改默认IP
sed -i 's/192.168.1.1/192.168.7.1/g' package/base-files/files/bin/config_generate
# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile
#修改主机名
sed -i 's/OpenWrt/Bin-Lean/g' package/base-files/files/bin/config_generate
#关闭自建私有源签名验证
sed -i '90d' package/system/opkg/Makefile
#固件主页版本信息显示编译日期
sed -i 's/OpenWrt/Bin AutoBuild ${{ env.DATE1 }} @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings
#修改在线安装插件私有源
sed -i '/lede/ { s/downloads/https\:\/\/downloads/g }' package/lean/default-settings/files/zzz-default-settings
sed -i '/lede/ { s/mirrors/https\:\/\/mirrors/g }' package/lean/default-settings/files/zzz-default-settings
sed -i '/lede/ { s/org/org\/snapshots/g }' package/lean/default-settings/files/zzz-default-settings
sed -i '/openwrt_luci/ { s/sed/# sed/g; }'  package/lean/default-settings/files/zzz-default-settings
sed -i 's#https://mirrors.cloud.tencent.com/lede#http://256pd.top:9666/懒人版/bin#g' package/lean/default-settings/files/zzz-default-settings
#修改固件名显示内核版本
sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=k$(LINUX_VERSION)-/g' include/image.mk
