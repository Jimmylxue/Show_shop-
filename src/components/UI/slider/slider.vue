<template>
  <div class="slider">
    <div class="show">
      <el-carousel :interval="5000" arrow="always">
        <el-carousel-item v-for="item in sliders" :key="item.id">
          <img :src="item.sliderimg" width="100%" height="100%" alt />
        </el-carousel-item>
      </el-carousel>
    </div>
    <div class="conts">
      <div class="sliderImg">
        <div v-for="(item,index) in sliders" :class="delTag?'delTag':''" :key="index">
          <img :src="item.sliderimg" width="100%" height="100%" alt />
          <i v-show="delTag" @click="del(item.sliderid)" class="el-icon-delete"></i>
        </div>
      </div>
      <div class="btns">
        <el-button class="btn" @click="dialogVisible = true" type="success">添加轮播图</el-button>
        <el-button class="btn" v-show="!delTag" @click="delTag=!delTag" type="danger">删除轮播图</el-button>
        <el-button class="btn" v-show="delTag" @click="delTag=!delTag" type="primary">取消删除</el-button>
      </div>
    </div>
    <el-dialog title="添加轮播图" :visible.sync="dialogVisible" width="45%">
      <div>
        <p>推荐上传150px*250px的图片作为轮播图</p>
        <div class="addSlider">
          <div class="slid" v-show="imgs.length!==0" v-for="(item,index) in imgs" :key="index">
            <img :src="item" width="100%" height="100%" alt />
          </div>
          <!-- <div></div> -->
          <div class="add" @click="addFlag = true">
            <i class="el-icon-plus"></i>
          </div>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addSlider">确 定</el-button>
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
      sliders: [],
      delTag: false,
      addFlag: false,
      dialogVisible: false,
      imgs: []
    }
  },
  mounted() {
    this.getSlider()
  },
  methods: {
    async getSlider() {
      let res = await this.$api.slider.getSlider()
      this.sliders = res.data
    },
    closeImg() {
      this.addFlag = false
    },
    getImg(img) {
      img.map(item => {
        this.imgs.push(item)
      })
    },
    del(id) {
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
          console.log('id', id)
          this.$api.slider.delSlider({ sliderid: id }).then(res => {
            if (res.data.code === 200) {
              this.$swal('哟吼~', '删除成功~', 'success')
              this.getSlider()
              return
            }
            this.$swal('哟吼~', '删除失败~', 'error')
          })
        }
      })
    },
    async addSlider() {
      if (this.imgs.length === 0) {
        this.$swal('添加失败', '图片不能为空', 'error')
        this.dialogVisible = false
        return
      }
      let res = await this.$api.slider.addSlider({ imgs: this.imgs })
      this.dialogVisible = false
      if (res.data.code === 200) {
        this.$swal('哟吼~', '添加成功~', 'success')
        this.getSlider()
        return
      }
      this.$swal('哟吼~', '添加失败~', 'error')
    }
  }
}
</script>

<style lang="less" scoped>
.slider {
  .show {
    width: 920px;
    height: 500px;

    .el-carousel__item h3 {
      color: #475669;
      font-size: 18px;
      opacity: 0.75;
      line-height: 300px;
      margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
      background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n + 1) {
      background-color: #d3dce6;
    }
  }
  .conts {
    width: 100%;
    display: flex;
    .sliderImg {
      width: 1230px;
      // height: 200px;
      // background-color: red;
      margin-top: 10px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      & > div {
        width: 30%;
        height: 185px;
        margin-right: 10px;
        margin-bottom: 10px;
        position: relative;
        i {
          transform: scale(1.5);
          position: absolute;
          right: 10px;
          top: 10px;
        }
      }
    }
    .sliderImg::after {
      content: '';
      width: 30%;
    }
    .btns {
      flex-grow: 1;
      // background-color: red;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      .btn {
        margin: 5px 0;
      }
    }
  }
}

.delTag {
  border: 2px dashed #222;
}

.addSlider {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  .slid {
    width: 30%;
    height: 150px;
    margin: 5px;
  }
  .add {
    width: 30%;
    height: 150px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 2px solid #ccc;
    i {
      transform: scale(2);
    }
  }
}
.addSlider::after {
  content: '';
  width: 30%;
}
</style>