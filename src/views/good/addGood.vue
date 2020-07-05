<template>
  <div class="root addGoods">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品操作</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="imgs">
        <div>
          <p>商品主图</p>
          <div class="imgcontainer">
            <div v-for="(item, index) in good.img" :key="index" class="imga">
              <img :src="item" ref="goodimg" width="200px" height="200px" alt />
              <i class="el-icon-delete del" @click="delImg(0)"></i>
            </div>

            <!-- <div class="fa fa-plus fa-2x" v-show="goodimg.length == 0" aria-hidden="true">
              <input type="file" @change="changeimg" class="file" />
            </div>-->
            <div
              class="fa fa-plus fa-2x"
              @click="openImgPlugin(0)"
              v-show="good.img.length == 0"
              aria-hidden="true"
            ></div>
          </div>
        </div>
        <div>
          <p>细节图片</p>
          <div class="imgcontainer">
            <div v-for="(item, index) in good.imgs" :key="index" class="imga">
              <img :src="item" ref="goodimg" width="200px" height="200px" alt />
              <i class="el-icon-delete del" @click="delImg(1,index)"></i>
            </div>
            <div
              class="fa fa-plus fa-2x"
              @click="openImgPlugin(1)"
              v-show="goodimg.length == 0"
              aria-hidden="true"
            ></div>
            <!-- <div class="fa fa-plus fa-2x" aria-hidden="true">
              <input type="file" @change="changeimgs" class="file" />
            </div>-->
          </div>
        </div>
      </div>
      <el-form
        :label-position="labelPosition"
        label-width="80px"
        :rules="rules"
        ref="good"
        :model="good"
      >
        <el-form-item label="商品名称" prop="name">
          <el-input v-model="good.name"></el-input>
        </el-form-item>
        <el-form-item label="商品描述" prop="desc">
          <el-input type="textarea" v-model="good.desc"></el-input>
        </el-form-item>
        <el-form-item label="商品价格" prop="price">
          <el-input v-model="good.price"></el-input>
        </el-form-item>
        <div class="spans">
          <el-form-item label="所属分类" prop="classify">
            <el-select @change="selChassify" v-model="good.classify" placeholder="请选择">
              <el-option
                v-for="item in classOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="所属品牌" prop="brand">
            <el-select @change="selBrand" v-model="good.brand" placeholder="请选择">
              <el-option
                v-for="item in brandOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-form-item>
        </div>

        <el-form-item label="商品规格" prop="capacity">
          <el-input v-model="good.capacity"></el-input>
        </el-form-item>
        <el-form-item label="是否包邮" class="freight">
          <el-radio-group v-model="radio1">
            <el-radio-button label="是"></el-radio-button>
            <el-radio-button label="否"></el-radio-button>
          </el-radio-group>
          <el-input v-show="radio1 === '否'" v-model="good.freight" label="请输入具体的邮费"></el-input>
        </el-form-item>
        <el-form-item label="二手产品">
          <el-radio-group v-model="good.type">
            <el-radio-button label="是"></el-radio-button>
            <el-radio-button label="否"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-button class="add" v-show="!edFlag" @click="add('good')" type="primary">立即添加</el-button>
        <el-button class="add" v-show="edFlag" @click="edit('good')" type="primary">立即修改</el-button>
      </el-form>
    </el-card>
    <img-load @out="closeImg" @hasSelect="getImg" v-show="imgPluginFlag"></img-load>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import imgLoad from '@/components/imgLoad/imgLoad.vue'
export default {
  components: {
    imgLoad
  },
  data() {
    return {
      labelPosition: 'right',
      // 包邮的flag
      radio1: '是',
      good: {
        name: '',
        desc: '',
        price: null,
        classify: '',
        brand: '',
        // 规格
        capacity: '',
        // 是否二手
        type: '',
        // 邮费
        freight: 0,
        img: [],
        imgs: [],
        goodid: null
      },
      rules: {
        name: [
          { required: true, message: '请输入商品名称', trigger: 'blur' },
          {
            min: 4,
            max: 20,
            message: '长度在 4 到 20 个字符',
            trigger: 'blur'
          }
        ],
        desc: [
          { required: true, message: '请输入商品描述', trigger: 'blur' },
          {
            min: 20,
            max: 300,
            message: '长度在 20 到 300 个字符',
            trigger: 'blur'
          }
        ],
        price: [{ required: true, message: '请输入商品价格', trigger: 'blur' }],
        classify: [
          { required: true, message: '请选择商品分类', trigger: 'blur' }
        ],
        brand: [
          { required: true, message: '请输入商品品牌', trigger: 'blur' },
          { min: 2, max: 99, message: '请输入正确的品牌名称', trigger: 'blur' }
        ],
        capacity: [
          { required: true, message: '请输入商品规格', trigger: 'blur' },
          { min: 3, max: 20, message: '规格不正确', trigger: 'blur' }
        ]
      },

      classOptions: [
        {
          value: 1,
          label: '手机'
        },
        {
          value: 2,
          label: '电脑'
        },
        {
          value: 3,
          label: '耳机'
        },
        {
          value: 4,
          label: '电视'
        },
        {
          value: 5,
          label: '手表/手环'
        }
      ],
      brandOptions: [
        {
          value: 1,
          label: '华为'
        },
        {
          value: 2,
          label: '小米'
        },
        {
          value: 3,
          label: '苹果'
        }
      ],
      goodimg: [], //主图
      goodimgs: [], //细节图片
      lab: '',
      btnText: '立即添加',
      goodMsg: {}, //  编辑的原始数据
      edFlag: false,
      imgFlag: 0, // 图片添加位置的flag 为0表示添加主图，1表示添加细节图
      imgPluginFlag: false //图片插件的显示
    }
  },
  watch: {
    radio1(newval) {
      if (newval === '是') {
        this.good.freight = 0
        return
      }
    }
  },
  mounted() {
    let goodid = this.$route.query.goodid
    // console.log()
    if (goodid) {
      this.edFlag = true
      this.btnText = '立即修改'
      this.getOneGood(goodid)
    }
  },
  methods: {
    ...mapActions(['addGood']),
    getImg(value) {
      if (this.imgFlag === 0) {
        this.good.img.length = 0
        this.good.img.push(value[0])
      } else {
        this.good.imgs.push(value[0])
        console.log('xyz', this.good.imgs)
      }
      console.log('aabc', value)
    },

    delImg(flag, index) {
      // flag为0表示主图 1表示详情图片
      if (flag === 0) {
        console.log('comming')
        console.log(this.goodimg)
        this.good.img.pop()
        return
      }
      this.good.imgs.splice(index, 1)
    },

    //选择类型
    selChassify(e) {
      // 默认传递一个参数 这个参数就是遍历的数据数组的value值
      this.good.classify = this.classOptions.filter(
        item => item.value === e
      )[0].label
    },
    // 选择品牌
    selBrand(e) {
      this.good.brand = this.classOptions.filter(
        item => item.value === e
      )[0].label
    },
    //获取商品信息
    async getOneGood(goodid) {
      let res = await this.$api.good.getOneGood({ goodid })
      this.goodMsg = res.data[0]
      console.log(this.goodMsg)
      this.good.goodid = this.goodMsg.goodid
      this.good.img.push(this.goodMsg.goodimg)
      if (this.goodMsg.imgs !== null) {
        this.good.imgs = this.goodMsg.imgs.split('@')
      }

      this.good.name = this.goodMsg.goodname
      this.good.desc = this.goodMsg.gooddesc
      this.good.price = this.goodMsg.price
      this.good.classify = this.goodMsg.classify
      this.good.brand = this.goodMsg.brand
      this.good.capacity = this.goodMsg.capacity
      this.good.type = this.goodMsg.type
      this.good.freight = this.goodMsg.freight
      // this.good.img = this.goodMsg.
      console.log(',,,', this.good)
    },
    // 提交
    async add(good) {
      console.log(this.good)
      this.$refs[good].validate(valid => {
        if (valid) {
          if (this.good.img.length !== 0) {
            console.log(this.good)
            this.addGood(this.good).then(code => {
              // console.log(code)
              if (code === 200) {
                this.$swal('哟吼~', '添加成功~', 'success')
                this.good = {}
                this.$router.push('/goods')
                return
              }
              this.$swal('哎哟~', '失败~', 'warning')
            })
            return
          }
          this.$swal('哎哟~', '还要上传图片哦~', 'warning')
        } else {
          this.$swal('哎哟~', '信息要填写完全哦~', 'warning')
          return false
        }
      })
    },
    edit(good) {
      console.log(this.good)
      this.$refs[good].validate(valid => {
        if (valid) {
          if (this.good.img.length !== 0) {
            this.$api.good.editGood(this.good).then(res => {
              if (res.data.code === 200) {
                this.$swal('哟吼~', '修改成功~', 'success')
                this.good = {}
                this.$router.push('/goods')
                return
              }
            })
            return
          }
          this.$swal('哎哟~', '还要上传图片哦~', 'warning')
        } else {
          this.$swal('哎哟~', '信息要填写完全哦~', 'warning')
          return false
        }
      })
    },
    openImgPlugin(flag) {
      // flag为0表示主图  1表示细节多图
      this.imgFlag = flag
      this.imgPluginFlag = true
    },
    closeImg(flag) {
      this.imgPluginFlag = false
    }
  }
}
</script>

<style lang="less" scoped>
.root {
  padding: 20px;
}
.el-card {
  margin-top: 15px;
  .el-table {
    margin-top: 15px;
  }
}
.imgs {
  width: 100%;
  height: 250px;
  display: flex;

  & > div {
    & > p {
      padding: 5px 0;
    }
    .imgcontainer {
      display: flex;
      div {
        width: 200px;
        height: 200px;
        border: 1px dashed rgb(228, 228, 228);
        color: rgb(228, 228, 228);
        display: flex;
        justify-content: center;
        align-items: center;
        font-weight: 100;
        position: relative;
      }
      .imga {
        position: relative;
        margin-right: 5px;
        img {
          border: 1px dashed #e4e4e4;
        }
        .del {
          position: absolute;
          right: 5px;
          top: 5px;
          font-size: 23px;
          display: none;
        }
        &:hover .del {
          display: block;
          color: #e67e22;
        }
      }
      .file {
        display: block;
        width: 100%;
        height: 100%;
        position: absolute;
        opacity: 0;
      }
    }
  }
  & > div:nth-child(1) {
    margin-right: 50px;
  }
}
.add {
  width: 200px;
}

.spans {
  display: flex;
}
</style>
