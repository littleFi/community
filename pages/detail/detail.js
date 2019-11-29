//content.js
//获取应用实例
const app = getApp()

import tip from '../../utils/tip'
import {dynamicDetail, getDynamicComment, dynamicComment, replyComment, dynamicLike} from "../../utils/api";

Page({
    data: {
        detail:null,
        commentList:[],
        id:0,
        page:0,
        commentId:0,
        isComment:false,
        isReply:false,
        secondComment:null,
        content:'',
        secondContent:''
    },

    onLoad: function (options) {
        let id = options.id
        this.getDynamicDetail(id)
        this.getComment(id)
        this.setData({
            id:id
        })
    },

    comment: function () {
        this.setData({
            isComment:!this.data.isComment,
            isReply:false
        })
    },
    //获取动态详细
    getDynamicDetail: function (id) {
        let params = {}
        let self = this
        dynamicDetail(params,id).then( res => {
            let detail = res.data.obj;
            self.setData({
                detail:detail
            })
        },err =>{
            tip.toast(err.msg)
        })
    },

    commentReply: function(e) {
        let index = e.currentTarget.dataset.index
        let replyId = this.data.commentList[index].id
        this.setData({
            isComment:false,
            commentId:replyId,
            secondComment:null,
            isReply:!this.data.isReply,
        })
    },
    //获取一级评论
    getComment: function (id) {
        let params={}
        let self = this
        let page = self.data.page
        getDynamicComment(params,id,page).then( res => {
            let data = res.data.obj;
            self.setData({
                commentList:data
            })
        },err => {
            tip.toast(err.msg)
        })
    },

    writeReply:function(e) {
        let self = this
        let value = e.detail.value;
        let secondComment = this.data.secondComment
        let params = {
            query:{
                "commentId": secondComment ? secondComment.commentId : self.data.commentId,
                "content": value,
                "secondCommentId": secondComment ? secondComment.secondCommentId : 0,
                "secondUserId": secondComment ? secondComment.secondUserId : 0
            },
            method: "POST"
        }
        console.log(params)
        replyComment(params).then( res => {
            if(res.data.code == 1){
                tip.toast("评论成功",{},'none');
                self.setData({
                    isReply:false,
                    secondContent:''
                })
                self.getComment(this.data.id)
            }
        })
    },
    //写评论
    writeComment: function (e) {
        let self = this
        let value = e.detail.value;
        let params = {
            "content": value,
            "situationId": this.data.id
        }
        dynamicComment(params).then( res => {
            if(res.data.code == 1){
                tip.toast("评论成功",{},'none');
                self.setData({
                    isComment:false,
                    content:''
                })
                self.getComment(this.data.id)
            }
        })
    },

    //点赞
    praise:function() {
        let params = {}
        let self = this
        let id = this.data.id
        let praiseCount = this.data.detail.praiseCount
        dynamicLike(params,id).then( res => {
            if(res.data.code == 1){
                praiseCount++
                tip.toast("点赞成功",function(){},'none')
            }else{
                praiseCount--
                tip.toast("取消点赞",function(){},'none')
            }
            let key = 'detail.praiseCount'
            self.setData({
                [key]:praiseCount
            })
        })
    },

    //图片预览
    preview:function(e) {
        let index = e.currentTarget.dataset.id
        let images = this.data.detail.imgUrl
        let url = images[index]
        let arr = []
        Object.keys(images).forEach( item => {
            if(images[item]){
                arr.push(images[item])
            }
        })
        qq.previewImage({
            current: url, // 当前显示图片的http链接
            urls: arr // 需要预览的图片http链接列表
        })
    },

    //二级回复
    replySecond: function (e) {
        let id = e.currentTarget.dataset.id
        let index = e.currentTarget.dataset.index
        let secondComment = this.data.commentList[id].secondComment[index]
        this.setData({
            isComment:false,
            secondComment:secondComment,
            isReply:!this.data.isReply,
        })
    }
})
