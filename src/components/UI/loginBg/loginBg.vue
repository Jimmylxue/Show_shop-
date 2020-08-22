<template>
  <div class="loginBg">
    <h3>当前背景</h3>
    <div class="nowBg">
      <img :src="selBackground" alt />
      <div>
        <el-button @click="dialogVisible=true" type="success">添加背景</el-button>
        <el-button v-show="delFlags==1" @click="delFlags = 2" type="danger">删除背景</el-button>
        <el-button v-show="delFlags==2" type="primary" @click="delFlags=1">取消删除</el-button>
      </div>
    </div>
    <h3>其他背景</h3>
    <div class="other">
      <div
        v-for="(item,index) in bgList"
        @click="selThis(item.id)"
        :class="delFlags==2?'wannaDel':''"
        :key="index"
      >
        <img :src="item.background" alt />
        <i @click.stop="wannaDel(item.id)" v-if="delFlags == 2" class="el-icon-delete"></i>
      </div>
    </div>
    <el-dialog title="添加背景图片" :visible.sync="dialogVisible" width="70%">
      <el-form>
        <el-form-item label="背景图片链接">
          <el-col :span="10">
            <el-input v-model="imgUrl" placeholder="请输入背景图片路径"></el-input>
          </el-col>
        </el-form-item>
        <el-form-item>
          <div class="preview" v-if="imgUrl!=''">
            <i @click="delSelectImg" class="el-icon-delete"></i>
            <img :src="imgUrl" alt />
          </div>

          <div v-else class="addImg" @click="addFlag=true">
            <i class="el-icon-plus"></i>
          </div>
          <small>建议上传长尺寸的长图~</small>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confrimAdd">确 定</el-button>
      </span>
    </el-dialog>
    <img-load v-show="addFlag" @hasSelect="getImg" @out="closeImg"></img-load>
  </div>
</template>

<script>
import imgLoad from '@/components/imgLoad/imgLoad.vue'
export default {
  components: {
    imgLoad
  },
  data() {
    return {
      addFlag: false,
      delFlags: 1,
      dialogVisible: false,
      bgList: [],
      imgUrl: '',
      selBackground: ''
    }
  },
  mounted() {
    this.getBgList()
  },
  methods: {
    async getBgList() {
      let res = await this.$api.loginBg.getBgList()
      this.bgList = res.data
      console.log(this.bgList)
      this.nowSelBg()
    },
    nowSelBg() {
      console.log('sell', this.bgList.filter(item => item.status == 1)[0])
      this.selBackground = this.bgList.filter(
        item => item.status == 1
      )[0].background
    },
    getImg(url) {
      this.imgUrl = url[0]
      console.log(url)
    },
    closeImg() {
      this.addFlag = false
    },
    delSelectImg() {
      this.imgUrl = ''
    },
    changeDel() {
      alert('what')
      this.delFlags = 2
      console.log('is')
    },
    async confrimAdd() {
      let params = {}
      params.img = this.imgUrl
      let res = await this.$api.loginBg.addLoginBg(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '添加成功~', 'success')
        this.dialogVisible = false
        this.getBgList()
        return
      }
      this.$swal('哦吼~', res.data.result, 'warning')
    },
    wannaDel(id) {
      let params = {}
      params.id = id
      console.log(params)
      this.$swal({
        title: '您确定要删除这张背景图片吗？',
        text: '删除后将无法恢复，请谨慎操作！',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dd6b55',
        confirmButtonText: '是的,我要删除',
        cancelButtonText: '容我三思',
        dangerMode: true
      }).then(willDelete => {
        if (willDelete.value) {
          this.toDel(params)
        }
      })
    },
    async toDel(params) {
      let res = await this.$api.loginBg.delLoginBg(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '删除~', 'success')
        this.getBgList()
        return
      }
      this.$swal('哦吼~', res.data.result, 'warning')
    },
    selThis(id) {
      if (this.delFlags == 2) {
        return
      } else {
        this.$swal({
          title: '您确定要切换这张照片当做背景图片吗？',
          text: '设置后原来的效果可能会消失',
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#67C23A',
          confirmButtonText: '是的,我要切换',
          cancelButtonText: '容我三思',
          dangerMode: true
        }).then(willDelete => {
          if (willDelete.value) {
            let params = {}
            params.id = id
            this.changeBg(params)
          }
        })
      }
      // console.log(id)
    },
    async changeBg(params) {
      let res = await this.$api.loginBg.changeBg(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '背景图片切换成功~', 'success')
        this.getBgList()
      } else {
        this.$swal('哦吼~', '开小差了，请稍后重试~', 'warning')
      }
    }
  }
}
</script>

<style lang="less" scoped>
h3 {
  margin: 20px 0;
}
h3:nth-child(1) {
  margin-top: 10px;
}
.nowBg {
  display: flex;
  align-items: center;
  img {
    width: 1050px;
    height: 500px;
  }
  > div {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    button {
      margin: 5px 0;
    }
  }
}
.other {
  width: 100%;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  > div {
    width: 31%;
    margin: 8px 0;
    position: relative;
    > img {
      width: 100%;
      height: 100%;
    }
    i {
      position: absolute;
      right: 10px;
      top: 10px;
      font-size: 23px;
      color: #ccc;
    }
  }
}
.other::after {
  content: '';
  width: 31%;
}
.addImg {
  width: 150px;
  height: 150px;
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  i {
    font-size: 20px;
    color: #ccc;
  }
}

.preview {
  width: 275px;
  height: 160px;
  position: relative;
  border: 1px dashed #ccc;
  img {
    width: 100%;
    height: 100%;
  }
  i {
    position: absolute;
    right: 5px;
    top: 8px;
    font-size: 20px;
  }
}
.wannaDel {
  border: 2px dashed #ccc;
}
</style>