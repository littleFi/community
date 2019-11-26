//content.js
//获取应用实例
const app = getApp()
import WxParse from "../../plugins/wxParse/wxParse"
import {corporationInfo, article, writeComment, comments, follow, like, cancelFocus} from '../../utils/api'
import tip from '../../utils/tip'

Page({
    data: {
        motto: 'Hello World',
        userInfo: {},
        hasUserInfo: false,
        canIUse: qq.canIUse('button.open-type.getUserInfo'),
        id:0,
        article:null,
        comments:null,
        corporationInfo:null,
        dialog:false,
        options:[
            {name: '1', value: '网络钓鱼/广告'},
            {name: '2', value: '人身攻击'},
            {name: '3', value: '侵权'},
            {name: '4', value: '谣言'},
            {name: '5', value: '政治'},
            {name: '6', value: '色情'}
        ],
        content:null
    },
    //事件处理函数
    bindViewTap: function () {
        qq.navigateTo({
            url: '../logs/logs'
        })
    },
    onLoad: function (options) {
        let id = options.id;
        this.setData({
            id:id
        })
        this.loadArticle(id);
        this.loadComments(id);
        this.loadCorporation()
    },

    //文章内容
    loadArticle:function(id) {
        let params = {}
        let self = this
        article(params,id).then( res => {
            let data = res.data.obj;
            self.setData({
                article:data
            })
            WxParse.wxParse('detailInfo', 'html', data.context, self);
        },err => {
            console.log("请求失败")
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
    //获取一级评论
    loadComments: function (id) {
        let params = {}
        let self = this
        comments(params,id,0).then( res => {
            let data = res.data.obj;
            console.log(data)
            self.setData({
                comments:data
            })
        },err => {
            console.log("请求失败")
        })
    },

    //社团信息
    loadCorporation:function() {
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

    //写评论
    writeComment: function(e) {
        let value = e.detail.value;
        let id = this.data.id;
        let self = this
        let params = {
            query:{
                "articleId": id,
                "content": value
            },
            method:"POST"
        }
        writeComment(params).then( res => {
            let data = res.data;
            if(data.code == 1){
                tip.toast("评论成功",{},'none');
                self.loadComments(id);
                self.setData({
                    content:''
                })
            }
        },err => {

        })
    },

    //取消
    cancel:function() {
        this.setData({
            dialog:false
        })
    },

    report: function () {
        this.setData({
            dialog:true
        })
    },
    //点赞
    like: function() {
        let self = this
        let id = this.data.id
        like({},id).then( res => {
            if(res.data.code == 1){
                tip.toast("点赞成功",{},'none')
                let num = this.data.articles.praiseCount++
                let article = "article.praiseCount"
                self.setData({
                    [article]:num
                })
            }
        })
    },
})
