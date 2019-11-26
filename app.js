//app.js
import {memberCount} from "./utils/api";

App({
  onLaunch: function () {
    // 登录
    this.getOpenid()

    // 获取用户信息
    qq.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          qq.getUserInfo({
            success: res => {
              // 可以将 res 发送给后台解码出 unionId
              this.globalData.userInfo = res.userInfo

              // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
              // 所以此处加入 callback 以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res)
              }
            }
          })
        }
      }
    })
  },


  globalData: {
    userInfo: null
  },

  // 获取openid和token
  getOpenid: function () {
      let apiUrl = "https://api.yayanshequ.com"
      qq.login({
          success: res => {
              console.log(res.code)
              let data = {
                  code:res.code,
                  openId:'String'
              }
              qq.request({
                  url: apiUrl + '/login/qq/login',
                  method: 'POST',
                  data: data,
                  header: {
                      'Content-Type': 'application/json'
                  },
                  success(res) {
                      if(res.data.code==1){
                          qq.setStorageSync("token",res.data.obj.access_token)
                          qq.setStorageSync("openid",res.data.obj.refresh_token) //openid
                          memberCount({})
                      }else{
                          console.log(res)
                      }
                  },
                  fail() {
                      console.log("请求登录接口出错")
                  }
              })
          }
      })
  }
})
