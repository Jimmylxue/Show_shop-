import gds from '../service/goods'

export default {
  state: {
    goodsMsg: [],
  },
  mutations: {
    pushGoodsMsg(state, msg) {
      state.goodsMsg = msg
    },
  },
  actions: {
    async getGoods({ state, commit }) {
      if (state.goodsMsg.length === 0) {
        // 没有数据才获取 避免频繁的请求
        let res = await (await gds.getGoods()).data
        commit('pushGoodsMsg', res)
      }
    },
  },
  getters: {},
}
