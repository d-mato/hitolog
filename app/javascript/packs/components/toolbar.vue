<template>
  <v-ons-toolbar>
    <div class="left">
      <v-ons-back-button v-if="back">Back</v-ons-back-button>
      <v-ons-toolbar-button @click="action" v-else>
        <v-ons-icon icon="ion-navicon, material:md-menu"></v-ons-icon>
      </v-ons-toolbar-button>
    </div>
    <div class="center"><slot></slot></div>
    <div class="right">
      <v-ons-toolbar-button @click="right_btn_action" v-if="right_btn_action">{{ right_btn_label }}</v-ons-toolbar-button>
    </div>
  </v-ons-toolbar>
</template>

<script>
export default {
  props: ['action', 'back', 'right_btn_action', 'right_btn_label'],
}
</script>
