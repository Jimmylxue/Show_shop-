<template>
  <div class="my">
    <div class="textContainer">
      <h2>Show_Shop</h2>
      <h3>永远相信，美好的事情即将发生！</h3>
    </div>
    <div class="clientInfo">
      <div>
        <div>
          <i class="el-icon-s-custom"></i> 注册量
        </div>
        <div>
          <p>{{user.allCount||0}}</p>
          <p>
            <span>总注册量</span>
            <span>昨日{{user.yestodayCount||0}}</span>
          </p>
        </div>
        <div>
          <span>今日注册</span>
          <span>{{user.todayCount||0}}</span>
        </div>
      </div>
      <div>
        <div>
          <i class="el-icon-s-custom"></i> 会员量
        </div>
        <div>
          <p>{{vip.allCount||0}}</p>
          <p>
            <span>总会员量</span>
            <span>昨日{{vip.yestodayCount||0}}</span>
          </p>
        </div>
        <div>
          <span>今日会员量</span>
          <span>{{vip.todayCount||0}}</span>
        </div>
      </div>
      <div>
        <div>
          <i class="el-icon-s-custom"></i> 订单量
        </div>
        <div>
          <p>{{order.allCount||0}}</p>
          <p>
            <span>总订单量</span>
            <span>昨日{{order.yestodayCount||0}}</span>
          </p>
        </div>
        <div>
          <span>今日订单量</span>
          <span>{{order.todayCount||0}}</span>
        </div>
      </div>
      <div>
        <div>
          <i class="el-icon-s-custom"></i> 营业额
        </div>
        <div>
          <p>{{price.allCount||0}}.00</p>
          <p>
            <span>总营业额</span>
            <span>昨日{{price.yestodayCount||0}}.00</span>
          </p>
        </div>
        <div>
          <span>今日营业额</span>
          <span>{{price.todayCount||0}}.00</span>
        </div>
      </div>
    </div>
    <div class="FinanccInfo">
      <div class="orderMes">
        <div class="head_title">
          <i class="el-icon-s-custom"></i> 订单趋势分析
        </div>
        <div class="main_pic">
          <canvas id="myChart2"></canvas>
        </div>
      </div>
      <div class="user_bank">
        <div class="rankList">
          <div class="mostPeson">
            <div class="head_title">
              <i class="el-icon-s-custom"></i> 用户下单趋势分析
            </div>
            <div class="rank">
              <canvas id="userRank" height="400%"></canvas>
            </div>
          </div>
          <div class="mostGood">
            <div class="head_title">
              <i class="el-icon-s-custom"></i> 商品趋势分析
            </div>
            <div class="rank">
              <canvas id="goodRank" height="400%"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Chart from 'chart.js'
export default {
  data() {
    return {
      goodName: [
        '小米10',
        'OPPO findX2',
        '黑鲨游戏手机',
        'iPhone 11',
        'HUAWEI P40 PRO'
      ],
      user: {},
      order: {},
      vip: {},
      price: {}
    }
  },
  created() {
    this.getMsg()
  },
  mounted() {
    let ctx2 = document.getElementById('myChart2')
    let myChart2 = new Chart(ctx2, {
      type: 'line',
      data: {
        labels: [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ],
        datasets: [
          {
            label: '各个月份销售额',
            backgroundColor: 'rgba(225,10,10,0.3)',
            // backgroundColor: 'rgba(225,10,10,0.3)',
            borderColor: 'rgba(225,103,110,1)',
            borderWidth: 1,
            pointStrokeColor: '#fff',
            pointBackgroundColor: 'rgba(225,10,10,0.3)',
            pointBorderColor: 'rgba(225,10,10,0.3)',
            pointHitRadius: '5',
            pointBorderWidth: '8',
            pointStyle: 'crossRot',
            data: [65, 59, 0, 81, 56, 10, 40, 22, 32, 54, 10, 30],
            cubicInterpolationMode: 'monotone',
            spanGaps: 'false', // 如果缺失点是否中断
            fill: 'false'
          }
        ]
      },
      options: {}
    })

    let ctx = document.getElementById('userRank')
    let myChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['xuexue', 'Jack', 'Rock', 'Jordan', 'Jimmy'],
        datasets: [
          {
            label: '# of 用户消费',
            data: [10, 11, 12, 14, 7, 1],
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(153, 102, 255, 1)',
              'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
          }
        ]
      },
      options: {
        title: {
          display: true,
          text: '用户下单排行'
        }
      }
    })

    let ctx1 = document.getElementById('goodRank')
    let myChart1 = new Chart(ctx1, {
      type: 'bar',
      data: {
        labels: this.goodName,
        // labels: ['xiaomi', 'xiaohou', 'xiaolajiao', 'tianmao', 'xiaoliu'],
        datasets: [
          {
            label: '# of 商品销量',
            data: [10, 11, 12, 14, 7, 1],
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)'
              // 'rgba(255, 159, 64, 0.2)',
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(153, 102, 255, 1)'
              // 'rgba(255, 159, 64, 1)',
            ],
            borderWidth: 1
          }
        ]
      },
      options: {
        title: {
          display: true,
          text: '商品销量排行'
        }
      }
    })
  },
  methods: {
    async getMsg() {
      let res = await this.$api.allMsg.getMsg()
      if (res.data.code == 200) {
        this.user = res.data.message.user
        this.vip = res.data.message.vip
        this.order = res.data.message.order
        this.price = res.data.message.price
      }
    }
  }
}
</script>

<style lang="less" scope>
* {
  margin: 0;
  padding: 0;
}
.my {
  width: 100%;
  height: 100%;
  background: url('../assets/img/bg2.png');
  display: flex;
  flex-direction: column;
  // justify-content: center;
  align-items: center;
  .textContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 800px;
    // height: 300px;
    // border: 1px solid black;
    color: white;
    margin-top: 30px;
    h3 {
      padding-top: 20px;
    }
  }
}
.clientInfo {
  width: 100%;
  display: flex;
  padding: 0 15px;
  justify-content: space-between;
  margin-top: 20px;
  > div {
    width: 23%;
    height: 200px;
    background-color: #fff;
    background-color: rgba(255, 255, 255, 0.5);
    display: flex;
    flex-direction: column;
    padding: 0 10px;
    > div {
      border-bottom: 1px solid #ccc;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    > div:nth-child(1) {
      height: 50px;
      font-size: 16px;
      font-weight: bold;
      flex-direction: row;
      justify-content: flex-start;
      align-items: center;
      > i {
        color: #1890ff;
        background-color: #e6f7ff;
        border-radius: 50%;
        padding: 4px;
        font-size: 16px;
        margin-right: 5px;
      }
    }
    > div:nth-child(2) {
      flex-grow: 1;
      > p:nth-child(1) {
        font-size: 30px;
        font-weight: 400;
        height: 60px;
        line-height: 70px;
      }
      > p:nth-child(2) {
        display: flex;
        width: 100%;
        justify-content: space-between;
        color: #212121;
        font-size: 15px;
      }
    }
    > div:nth-child(3) {
      height: 50px;
      color: #8c8c8c;
      justify-content: space-between;
      flex-direction: row;
      align-items: center;
      border-bottom: none;
    }
  }
}

.FinanccInfo {
  width: 98%;
  height: 520px;
  // background-color: rgba(255, 255, 255, 0.5);
  margin-top: 20px;
  display: flex;
  justify-content: space-between;

  .orderMes {
    width: 55%;
    border: 1px solid #ccc;
    background-color: rgba(255, 255, 255, 0.5);
    display: flex;
    flex-direction: column;
    .head_title {
      width: 100%;
      height: 50px;
      display: flex;
      align-items: center;
      border-bottom: 1px solid #ccc;
      padding: 0 10px;
      i {
        color: #1890ff;
        background-color: #e6f7ff;
        border-radius: 50%;
        padding: 4px;
        font-size: 16px;
        margin-right: 5px;
      }
    }
    .main_pic {
      height: 470px;
    }
  }
  .user_bank {
    width: 43%;
    border: 1px solid #ccc;
    background-color: rgba(255, 255, 255, 0.5);
    .head_title {
      width: 100%;
      height: 50px;
      display: flex;
      align-items: center;
      border-bottom: 1px solid #ccc;
      padding: 0 10px;
      i {
        color: #1890ff;
        background-color: #e6f7ff;
        border-radius: 50%;
        padding: 4px;
        font-size: 16px;
        margin-right: 5px;
      }
    }
    .rankList {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: space-between;
      > div {
        width: 48%;
        height: 100%;
        // background-color: skyblue;
        .rank {
          width: 100%;
          height: 470px;
          // background-color: red;
        }
      }
    }
  }
}
</style>
