<template>
  <div class="imgLoad">
    <div class="img_head">
      <div class="title">
        <img src="@/assets/upload.png" width="45px" height="45px" alt />
        <span>图片上传</span>
      </div>
      <div class="btns">
        <ul>
          <li>
            <el-button
              type="primary"
              v-if="!selMore"
              style="margin-right:20px"
              @click="changeSelMode"
              icon="el-icon-star-off"
            >开启多选</el-button>
          </li>
          <li>
            <el-button
              type="primary"
              v-if="selMore"
              style="margin-right:20px"
              @click="changeSelMode"
              icon="el-icon-star-off"
            >关闭多选</el-button>
          </li>
          <li>
            <el-button type="success" @click="useImg" icon="el-icon-s-promotion">使用</el-button>
          </li>
          <li class="fileBtn">
            <el-button type="primary" @click="dialogVisible = true" icon="el-icon-folder">上传</el-button>
          </li>
          <li>
            <el-button type="danger" @click="delImg" icon="el-icon-delete">删除</el-button>
          </li>
        </ul>
      </div>
      <div class="out" @click="toOut">
        <img src="@/assets/img/plugin/out.png" width="40px" height="40px" alt />
      </div>
    </div>
    <div class="content">
      <div class="img_type">
        <ul>
          <li :class="clickFlag === 0 ? 'typeSelect' : ''" @click="reset">
            <i class="el-icon-folder-opened"></i>
            <span>ALL</span>
          </li>
          <li
            v-for="(item, index) in dir"
            :class="clickFlag === index + 1 ? 'typeSelect' : ''"
            @click="changeType(item, index)"
            :key="index"
          >
            <i class="el-icon-folder-opened"></i>
            <span>{{ item }}</span>
          </li>
        </ul>
      </div>
      <div class="imgs">
        <div v-for="(item, index) in imgs" :key="index">
          <img
            :src="item"
            width="150px"
            height="150px"
            @click="select(item)"
            :class="hasSelect.indexOf(item) !== -1 ? 'imgSelect' : ''"
            alt
          />
          <!-- <span>{{item}}</span> -->
        </div>
      </div>
    </div>
    <el-dialog title="上传图片" :visible.sync="dialogVisible" width="50%">
      <div class="upload_container">
        <span>请选择上传位置</span>
        <select class="sel" v-model="text">
          <option v-for="(item,index) in dir" :key="index">{{item}}</option>
        </select>
        <div class="img_con">
          <div class="see_imgs" v-for="(item,index) in goodimgs" :key="index">
            <img :src="item" width="100%" height="100%" alt />
            <i @click="see_del(index)" class="el-icon-delete"></i>
          </div>

          <div class="btn">
            <input @change="changeimgs" type="file" />
            <i class="el-icon-plus"></i>
          </div>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="uploads">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dir: [],
      allimgs: [],
      imgs: [],
      clickFlag: 0,
      hasSelect: [],
      selMore: false, // 多选状态  flase关闭多选
      dialogVisible: false,
      upLoad: {},
      text: '',
      goodimgs: [], // 预览图片的base64数据
      uploadImg: []
    }
  },
  computed: {
    dirObj() {
      let objArr = []
      let i = 0
      this.dir.map(item => {
        let obj = {}
        obj.lable = item
        obj.value = i
        objArr.push(obj)
        i++
      })
      console.log('789', objArr)
      return objArr
    }
  },
  watch: {
    text(newval, oldval) {
      console.log(newval, oldval)
    }
  },
  mounted() {
    this.getDir()
    this.getImgs()
  },
  methods: {
    async getDir() {
      let res = await this.$api.imgs.getDir()
      if (res.data.code === 200) {
        this.dir = res.data.result
      }
    },
    async getImgs() {
      let res = await this.$api.imgs.getImgs()
      let all = res.data.result
      this.allimgs = all
      // console.log(this.allimgs)
      all.map(item => {
        let part = item.url
        part.map(ia => {
          let url = 'http://127.0.0.1:666/' + item.name + '/' + ia
          this.imgs.push(url)
        })
      })
    },
    reset() {
      this.imgs.length = 0
      this.clickFlag = 0
      this.allimgs.map(item => {
        let part = item.url
        part.map(ia => {
          let url = 'http://127.0.0.1:666/' + item.name + '/' + ia
          this.imgs.push(url)
        })
      })
    },
    changeType(item, index) {
      this.imgs.length = 0
      this.clickFlag = index + 1
      // console.log(this.all)
      let obj = this.allimgs.filter(items => items.name === item)
      // console.log(obj)
      obj[0].url.map(item => {
        let url = 'http://127.0.0.1:666/' + obj[0].name + '/' + item
        this.imgs.push(url)
      })
    },
    changeSelMode() {
      if (this.selMore === true) {
        this.hasSelect.length = 0
        this.$swal('哟吼~', '多选已关闭~', 'success')
      } else {
        this.$swal('哟吼~', '多选已开启~', 'success')
      }
      this.selMore = !this.selMore
    },
    select(item) {
      let index = this.hasSelect.indexOf(item)
      if (this.selMore) {
        if (index == -1) {
          this.hasSelect.push(item)
        } else {
          this.hasSelect.splice(index, 1)
        }
        return
      }
      this.hasSelect.length = 0
      this.hasSelect.push(item)
    },
    useImg() {
      this.$swal('哟吼~', '使用成功~', 'success')
      this.$emit('hasSelect', this.hasSelect)

      // console.log(this.hasSelect)
    },
    changeimgs(e) {
      const files = e.target.files[0]
      const render = new FileReader()
      let imgFile
      render.readAsDataURL(files)
      render.onload = e => {
        imgFile = e.target.result
        const arr = imgFile.split(',')
        this.goodimgs.push(imgFile)
        let obj = {}
        obj.imgname = arr[0]
        obj.imgsrc = arr[1]
        this.uploadImg.push(obj)
      }
    },
    async uploads() {
      if (this.text == '') {
        this.$swal('哟吼~', '请选择图片上传的位置哦~', 'warning')
        return
      } else if (this.uploadImg.length === 0) {
        this.$swal('哟吼~', '请先选择图片了再上传~', 'warning')
        return
      }
      let params = {}
      params.filename = this.text
      params.files = this.uploadImg
      console.log(this.uploadImg)
      let res = await this.$api.imgs.upLoadImgs(params)
      if (res.data.code === 200) {
        this.dialogVisible = false
        this.$swal('哟吼~', '图片上传成功~', 'success')
        this.getImgs()
      } else {
        this.$swal('哎哟~', '出错了~', 'error')
        this.dialogVisible = false
      }
      this.goodimgs.length = 0
      this.uploadImg.length = 0
    },
    delImg() {
      if (this.hasSelect.length > 1) {
        this.$swal('哟吼~', '一次只能删除一个~', 'warning')
        return
      } else if (this.hasSelect.length === 0) {
        this.$swal('哟吼~', '请先选中再删除吧~', 'warning')
        return
      } else if (this.clickFlag === 0) {
        this.$swal('哟吼~', '为避免误删，请到指定文件夹再删除吧~', 'warning')
        return
      }
      this.$swal({
        title: '您确定要删除这张图片吗？',
        text: '删除后将无法恢复，请谨慎操作！',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dd6b55',
        confirmButtonText: '是的,我要删除',
        cancelButtonText: '容我三思',
        dangerMode: true
      }).then(willDelete => {
        if (willDelete.value) {
          let obj = this.hasSelect[0]
          let params = {}
          params.dir = obj.split(':')[2].split('/')[1]
          params.filename = obj.split(':')[2].split('/')[2]
          this.$api.imgs.delImg(params).then(res => {
            if (res.data.code === 200) {
              this.$swal('哟吼~', '删除成功~', 'success')
              this.clickFlag = 0
              this.getImgs()
              return
            }
            this.$swal('哟吼~', '出错了~', 'error')
          })
        }
      })
    },
    see_del(index) {
      this.goodimgs.splice(index, 1)
      this.uploadImg.splice(index, 1)
    },
    toOut() {
      this.$emit('out', false)
    }
  }
}
</script>

<style lang="less" scoped>
.imgLoad {
  width: 1100px;
  height: 600px;
  position: fixed;
  z-index: 2050;
  top: 42%;
  left: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 0 0 20px #ccc;
  display: flex;
  flex-direction: column;
  border: 8px solid #ccc;
}
.img_head {
  width: 100%;
  height: 70px;
  background-color: #fff;
  display: flex;
  border-bottom: 2px solid #f4f4f4;
  position: relative;
  .out {
    position: absolute;
    right: 25px;
    top: 15px;
    cursor: pointer;
  }
  .title {
    width: 230px;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 20px;
    span {
      margin-left: 10px;
    }
  }
  .btns {
    flex-grow: 1;
    display: flex;
    // background-color: red;
    align-items: center;
    ul {
      width: 100%;
      display: flex;
      list-style: none;
      li {
        display: flex;
        margin-right: 10px;
      }
    }
  }
}
.content {
  width: 100%;
  height: 530px;
  display: flex;
  .img_type {
    width: 230px;
    height: 100%;
    background-color: rgb(248, 248, 248);
    ul {
      list-style: none;
      li {
        width: 100%;
        height: 50px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        padding-left: 60px;
        cursor: pointer;
        i {
          font-size: 22px;
          margin-right: 5px;
        }
      }
      .typeSelect {
        background-color: #f1c40f;
        color: #fff;
      }
    }
  }
  .imgs {
    width: 870px;
    height: 100%;
    background-color: #fff;
    display: flex;
    // justify-content: space-between;
    // align-items: flex-start;
    padding: 0 10px;
    flex-wrap: wrap;
    overflow: auto;
    div {
      width: 22%;
      height: 170px;
      display: flex;
      padding: 10px;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin: 10px 0;
      .imgSelect {
        border: 5px solid #e67e22;
      }
    }
  }
}

.upload_container {
  width: 100%;
  // height: 520px;
  .sel {
    width: 200px;
    height: 45px;
    padding: 0 10px;
    border-radius: 8px;
    color: #222;
    border: 1px solid rgb(220, 223, 230);
    margin-left: 10px;
    margin-bottom: 15px;
    option {
      width: 100%;
      height: 45px;
    }
  }
  .sel:active {
    border: 1px solid rgb(220, 223, 230);
  }
  .img_con {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    .see_imgs {
      width: 30%;
      height: 150px;
      position: relative;
      &:hover i {
        display: block;
      }
      img {
        border: 2px dashed #ccc;
      }
      i {
        display: none;
        position: absolute;
        right: 5px;
        top: 10px;
        color: #e67e22;
        transform: scale(1.3);
        cursor: pointer;
      }
    }
    .btn {
      width: 150px;
      height: 150px;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      border: 2px dashed #ccc;
      input {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        opacity: 0;
      }
      i {
        transform: scale(1.3);
      }
    }
  }
  .img_con::after {
    content: '';
    width: 30%;
  }
}
</style>
