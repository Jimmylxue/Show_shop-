import gds from '../service/goods'

export default {
  state: {
    goodsMsg: [],
    addState: null,
    countMsg: [],
  },
  mutations: {
    pushGoodsMsg(state, msg) {
      state.goodsMsg = msg
    },
    changeAddState(state, msg) {
      state.addState = msg
    },
    pushCountMsg(state, msg) {
      state.countMsg = msg
    },
  },
  actions: {
    async getGoods({ state, commit }) {
      // if (state.goodsMsg.length === 0) {
      // 没有数据才获取 避免频繁的请求
      let res = await (await gds.getGoods()).data
      commit('pushGoodsMsg', res)
      // }
    },
    async addGood({ commit }, good) {
      let { code } = await (await gds.addGood(good)).data
      if (code === 1) {
        commit('changeAddState', true)
        return code
      }
      commit('changeAddState', false)
      return code
    },
    async selctCount({ commit }) {
      let res = await (await gds.getCount()).data
      commit('pushCountMsg', res)
    },
  },
  getters: {},
}
