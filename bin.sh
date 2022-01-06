#!/bin/bash
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
#修改默认feeds，添加passwall和helloworld
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#添加额外软件包
svn co https://github.com/siropboy/mypackages/trunk/luci-app-autopoweroff package/openwrt-packages/luci-app-autopoweroff
svn co https://github.com/siropboy/mypackages/trunk/luci-app-control-timewol package/openwrt-packages/luci-app-control-timewol
git clone https://github.com/binge8/luci-theme-argon-mc.git package/openwrt-packages/luci-theme-argon-mc
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/openwrt-packages/luci-theme-opentomcat
git clone https://github.com/binge8/luci-theme-butongwifi.git package/openwrt-packages/luci-theme-butongwifi
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/openwrt-packages/luci-theme-atmaterial
git clone https://github.com/binge8/luci-app-koolproxyR.git package/openwrt-packages/luci-app-koolproxyR
git clone https://github.com/binge8/luci-app-koolddns.git package/openwrt-packages/luci-app-koolddns
svn co https://github.com/0saga0/OpenClash/trunk/luci-app-openclash package/openwrt-packages/luci-app-openclash
svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom package/openwrt-packages/luci-theme-infinityfreedom
git clone https://github.com/lisaac/luci-app-dockerman.git package/openwrt-packages/luci-app-dockerman

./scripts/feeds update -a
./scripts/feeds install -a
