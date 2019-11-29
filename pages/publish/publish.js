import {publish,corpPublish, people} from '../../utils/api'
import tip from '../../utils/tip'

Page({
    data: {
        images:[],
        content:null,
        corp:null,
        checked:false, //是否选择了官方动态
        corpName:"#请选择社团",
        people:null
    },
    onLoad: function () {
        let corporation = qq.getStorageSync("corporation")
        if(corporation){
            this.setData({
                corpName:"当前社团："+corporation.name,
                corp:corporation
            })
        }
        this.getPeople()
    },

    //获取内容
    bindTextAreaBlur: function(e) {
        this.setData({
            content: e.detail.value,
        })
    },
    //获取个人信息
    getPeople: function() {
        let self = this
        people({}).then( res => {
            self.setData({
                people:res.data.obj
            })
        })
    },
    choose: function () {
        let self = this
        qq.chooseImage({
            count:9,
            success:function (res) {
                const tempFilePaths = res.tempFilePaths
                self.setData({
                    images:tempFilePaths
                })
            },
            fail: function () {
                
            }
        })
    },
    checkedTap: function() {
        this.setData({
            checked:!this.data.checked
        })
    },
    publish: function (e) {
        let images = []
        let files = this.data.images
        let corp = this.data.corp
        let checked = this.data.checked
        let people = this.data.people
        let content = e.detail.value.content

        if(Object.keys(people.userinfoExWithCorp.mapJoin).length < 1){
            tip.toast("您未加入任何社团，请先加入社团再发动态")
            return
        }
        if(!corp){
            tip.toast("请先选择社团")
            return
        }
        if(checked){
            let keys = Object.keys(people.userinfoExWithCorp.mapManage)
            let index = -1
            for (let i =0;i<keys.length;i++){
                if(i == corp.id){
                    index = i
                }
            }
            // let index = keys.indexOf(corp.id)
            if(index < 0){
                tip.toast("暂无发表官方动态的权限")
                return
            }
        }
        if(files.length > 0){
            //7de5512d-63a2-4ed1-895f-df842068fe5b
            let token = qq.getStorageSync("token")
            for (let i=0;i<files.length;i++){
                let url = "https://api.yayanshequ.com/file/upload/file/"+i
                qq.uploadFile({
                    url: url,
                    filePath: files[i],
                    name: 'file',
                    header: {
                        'content-type': 'multipart/form-data',
                        'Authorization': 'Bearer '+ token
                    },
                    formData: {
                    },
                    success(res) {
                        const data = res.data
                        images.push(data.url)
                    }
                })
            }
        }

        if(images.length <= 0 && !content){
            tip.toast("写点东西再发表吧")
            return
        }

        let params = {
            method:"POST",
            query:{
                "content": content,
                "corpId": this.data.corp.id,
                "imgUrl1": images[0],
                "imgUrl2": images[1],
                "imgUrl3": images[2],
                "imgUrl4": images[3],
                "imgUrl5": images[4],
                "imgUrl6": images[5],
                "imgUrl7": images[6],
                "imgUrl8": images[7],
                "imgUrl9": images[8],
                "userFlag": 0
            }
        }

        if(checked){
            corpPublish(params).then( res => {
                tip.toast("发表成功")
            })
        }else{
            publish(params).then( res => {
                tip.toast("发表成功")
            })
        }
        qq.switchTab({
            url: '../dynamic/dynamic'
        })
    },
    uploadImages: function () {


    },
    //社团选择页
    goToCorporation: function () {

        let people = this.data.people
        if(Object.keys(people.userinfoExWithCorp.mapJoin).length < 1){
            tip.toast("您未加入任何社团")
            return
        }

        qq.redirectTo({
            url: '../corporation/corporation'
        })
    },

    checkJoinCorp: function () {
        let people = this.data.people
    }
})
