
import {
    corporationInfo,
    cancelFocus,
    writeMessage,
    follow,
    updateHeadImg,
    updateNickName,
    getMessage,
    articleList,
    like
} from '../../utils/api'
import tip from '../../utils/tip'
import util from '../../utils/util'
Page({
  data: {
    articles:[],
    corporationInfo:null,
    messageList:null,
    corpId:5,
    height:null,
    headImg:'',
    content:''
  },

  onLoad: function (options) {
    let id = options.id || 5
    let corporation = qq.getStorageSync("community");
    let headImg = qq.getStorageSync("headImg");
    let name = "社团首页"
    if(corporation){
        name = corporation.name
    }
    qq.setNavigationBarTitle({
        title: name
    })
    this.setData({
        corpId:id,
        headImg:headImg
    })
    this.loadInfo();
    this.loadMessage();
    this.article()
  },

  //分享
  onShareAppMessage: function() {
      return {
          'title':'雅言社区',
          'path': '/pages/home/home'
      }
  },
    //社团文章列表
    article:function() {
        let params= {};
        let corpId = this.data.corpId;
        let self = this
        articleList(params,corpId,0).then( res => {
            if(res.data.code == 1){
                let articles = res.data.obj
                Object.keys(articles).forEach( item => {
                    articles[item].timeDiff = util.timeDiff(articles[item].time)
                })
                self.setData({
                    articles:articles
                })
            }
        })
    },
  loadInfo: function() {
      let self = this
      corporationInfo().then( res =>{
          let data = res.data.obj
          self.setData({
              corporationInfo: data
          })
      }, err => {
          console.log("请求错误")
      })
  },

  //点赞
  like: function(e) {
      let self = this
      let id = e.currentTarget.dataset.id
      let index = e.currentTarget.dataset.index
      let num = self.data.articles[index].praiseCount+1
      like({},id).then( res => {
          if(res.data.code == 1){
              tip.toast("点赞成功",{},'none')
              let article = "articles["+index+"].praiseCount"
              self.setData({
                  [article]:num
              })
          }
      })
  },
  //写留言
  writeMessage(e) {
      let self = this
      let value = e.detail.value
      let corpId = this.data.corpId
      let params = {
          query:{
              "content": value,
              "corpId": corpId
          },
          method: "POST"
      }
      writeMessage(params).then( res => {
          tip.toast("留言成功")
          self.setData({
              content:''
          })
      },err =>{
          console.log("请求错误")
      })
  },
    //关注和取消关注
    follow: function() {

      let focus = this.data.corporationInfo.focus;
      let params = {};
      let corpId = this.data.corpId;
      let self = this
      if(focus){
          cancelFocus(params,corpId).then( res => {
              let data = res.data
              if(data.code == 1){
                  tip.toast("取消关注",{},'none')
                  let key = "corporationInfo.focus"
                  self.setData({
                      [key]:0
                  })
              }
          }, err => {

          })
      }else{
          follow(params,corpId).then( res => {
              let data = res.data
              if(data.code == 1){
                  tip.toast("关注成功",{},'none')
                  let key = "corporationInfo.focus"
                  self.setData({
                      [key]:1
                  })
              }
          },err => {

          })
      }
  },

  //文章详细
  detail: function(e) {
      let id = e.currentTarget.dataset.id
      console.log(id)
      qq.navigateTo({
          url: '../content/content?id='+id
      })
  },

  //取消
  cancel:function() {
     this.setData({
      dialog:false
     })
  },

  //留言列表
  loadMessage: function() {
      let params = {}
      let self = this
      let corpId = this.data.corpId
      getMessage(params,corpId,0).then( res => {
          if(res.data.code == 1){
              let message = res.data.obj
              self.setData({
                  messageList:message
              })
          }
      })
  }
})
