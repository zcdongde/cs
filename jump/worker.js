export default {
    async fetch(request) {
      const url = new URL(request.url);
      const path = decodeURIComponent(url.pathname);
  
      // 在这里配置你的跳转名册，一行一个，极其方便
      const redirectMap = {
        "/1": "https://www.wolai.com/dongde/tsTWA4XkKVd8Yge771bnYZ",
        "/jump": "https://dash.cloudflare.com/a4e336ab6e9f11616db7b8b57ef78c1a/workers/services/edit/jump/production",
        "/工具箱": "https://raw.githubusercontent.com/zcdongde/cs/main/dongde自制指令工具箱.bat",
        "/云服务器": "https://ecs.console.aliyun.com/launch-template/region/cn-hangzhou",
        "/小软件": "https://www.kdocs.cn/mine/417445286722",
        "/大软件": "https://pan.quark.cn/s/491cf6a25dd4",
        "/g": "https://www.google.com",
        "/b": "https://www.baidu.com",
        "/github": "https://github.com",
        // 你可以继续往下加，没有上限
      };
  
      // 如果访问的路径在名册里，就执行跳转
      if (path in redirectMap) {
        return Response.redirect(redirectMap[path], 301);
      }
      // --- 新增的加速逻辑开始 ---
      // 判断路径是否以 /speed/ 开头
      if (path.startsWith("/speed/")) {
        // 1. 获取 /speed/ 后面的内容 (即你想要访问的GitHub网址)
        // 例如：访问 /speed/https://github.com/xxx -> 提取出 https://github.com/xxx
        let target = path.replace("/speed/", "");
            
        // 2. 这里填入你喜欢的加速前缀
        const speedPrefix = "https://github.catvod.com/";
            
        // 3. 拼接并执行跳转
        // 最终跳转到：https://github.catvod.com/https://github.com/xxx
        return Response.redirect(speedPrefix + target, 302);
      }
        // --- 新增的加速逻辑结束 ---

      // 如果不在名册里，可以让他正常访问，或者跳回首页
      // 如果想让没匹配到的都跳回首页，取消下面这一行的注释：
      // return Response.redirect("https://dongde.fun", 301);
  
      return fetch(request);
    },
  };
  