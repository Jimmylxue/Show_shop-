<template>
  <div class="rootv">
    <!-- <h2>产品视频</h2> -->
    <div class="container">
      <div @click="seeVideo(item.url)" v-for="(item,index) in videoList" :key="index" class="good">
        <img :src="item.img" width="100%" height="100%" alt />
        <span>{{item.title}}</span>
        <i @click="wannaDel(item.videoId)" class="el-icon-delete"></i>
      </div>
    </div>
    <el-card style="margin-top:15px">
      <div class="addContainer">
        <h4>添加视频</h4>
        <el-form label-position="top">
          <el-form-item label="视频标题">
            <el-col :span="10">
              <el-input v-model="vodeoMsg.title" placeholder="请输入视频标题"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="视频缩略图">
            <el-col></el-col>
            <small>建议上传长尺寸的视频封面哦~</small>

            <el-row>
              <div class="thumbnail" v-show="imgs.length != 0">
                <img
                  v-for="(item,index) in imgs"
                  width="250px"
                  height="140px"
                  :key="index"
                  :src="item"
                  alt
                />
                <i @click="delImg" class="el-icon-delete"></i>
              </div>

              <div
                v-show="imgs.length == 0"
                style="margin-top:10px"
                class="addImg"
                @click="addFlag=true"
              >
                <i class="el-icon-plus"></i>
              </div>
            </el-row>
          </el-form-item>
          <el-form-item label="视频文件">
            <el-row>
              <el-col :span="10">
                <el-input v-model="vodeoMsg.url" placeholder="请输入视频地址"></el-input>
              </el-col>
            </el-row>
            <!-- <el-row>
              <img v-for="(item,index) in imgs" :key="index" :src="item" alt />
              <div class="addImg" style="margin-top:10px" @click="addFlag=true">
                <i class="el-icon-plus"></i>
              </div>
            </el-row>-->
          </el-form-item>
          <el-form-item>
            <hr />
            <el-button style="margin-top:10px;" @click="addVideo" type="success">添加视频</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
    <div v-if="videoShowFlag" class="videos">
      <videoPlugin :url="seeVideoUrl" @closeVideo="videoShowFlag=false"></videoPlugin>
    </div>

    <img-load v-show="addFlag" @hasSelect="getImg" @out="closeImg"></img-load>
  </div>
</template>

<script>
import videoPlugin from '@/components/videoPlugin/myvideo.vue'
import imgLoad from '@/components/imgLoad/imgLoad.vue'
export default {
  components: {
    imgLoad,
    videoPlugin
  },
  data() {
    return {
      addFlag: false,
      imgs: [],
      videoShowFlag: false,
      videoList: [],
      seeVideoUrl: '',
      vodeoMsg: {
        title: '',
        img: '',
        url: ''
      }
    }
  },
  mounted() {
    this.imgList()
  },
  methods: {
    getImg(img) {
      console.log(img)
      img.map(item => {
        this.imgs.push(item)
      })
    },
    closeImg() {
      this.addFlag = false
    },
    delImg() {
      this.imgs = []
    },
    addVideo() {
      this.vodeoMsg.img = this.imgs[0]
      if (!this.vodeoMsg.img) {
        this.$swal('哟吼~', '未上传缩略图~', 'error')
      } else if (!this.vodeoMsg.title) {
        this.$swal('哟吼~', '未设置视频标题~', 'error')
      } else if (!this.vodeoMsg.url) {
        this.$swal('哟吼~', '未设置视频地址~', 'error')
      } else {
        this.upload()
      }
    },
    async imgList() {
      let res = await this.$api.video.getVideoLsit()
      this.videoList = res.data
    },
    async upload() {
      let params = this.vodeoMsg
      let res = await this.$api.video.uploadVideo(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '视频上传成功~', 'success')
        this.videoList = {}
        this.imgList()
        return
      }
      this.$swal('哟吼~', '可能信号干扰~请稍后重试!', 'error')
    },
    wannaDel(id) {
      this.$swal({
        title: '您确定要删除这个视频吗？',
        text: '删除后将无法恢复，请谨慎操作！',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dd6b55',
        confirmButtonText: '是的,我要删除',
        cancelButtonText: '容我三思',
        dangerMode: true
      }).then(willDelete => {
        if (willDelete.value) {
          let params = {}
          params.videoId = id
          this.$api.video.delVideo(params).then(res => {
            console.log(res)
            if (res.data.code == 200) {
              this.$swal('哟吼~', '删除成功~', 'success')
              this.imgList()
              return
            }
            this.$swal('哟吼~', res.data.result, 'error')
          })
        }
      })
    },
    seeVideo(url) {
      console.log(url)
      this.seeVideoUrl = url
      this.videoShowFlag = true
    }
  }
}
</script>

<style lang="less" scoped>
.rootv {
  width: 100%;
}
h2 {
  font-weight: normal;
  margin: 20px 0;
}
.container {
  width: 100%;
  // height: 300px;
  // background-color: #2ecc71;
  margin-top: 20px;
  display: grid;
  grid-template-rows: repeat(1, 1fr);
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 15px;
  justify-content: space-between;
  div {
    transition: all 0.3s ease-in-out;
    width: 355px;
    height: 290px;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    img {
      width: 100%;
      height: 200px;
      background-color: rosybrown;
    }
    span {
      margin-top: 25px;
    }
    i {
      position: absolute;
      font-size: 20px;
      bottom: 8px;
      right: 8px;
    }
  }
  .good:hover {
    box-shadow: 10px 10px 15px #ccc, -10px 10px 15px #ccc;
    transform: translateY(-5px);
  }
}

.addImg {
  width: 150px;
  height: 150px;
  position: relative;
  border: 2px dashed #ccc;
  i {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 20px;
    color: #ccc;
  }
}
.thumbnail {
  width: 250px;
  height: 140px;
  margin-top: 10px;
  border: 1px dashed #ccc;
  position: relative;
  i {
    position: absolute;
    right: 8px;
    top: 8px;
    font-size: 20px;
  }
}

.videos {
  position: absolute;
  width: 100%;
  top: 0;
  left: 0;
}
</style>