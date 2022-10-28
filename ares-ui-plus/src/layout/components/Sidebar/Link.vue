<template>
  <!-- eslint-disable vue/require-component-is -->
  <component :is="type(to)" v-bind="linkProps(to)">
    <slot />
  </component>
</template>

<script>
import { isExternal } from "@/utils/validate";

export default {
  name: "Link",
  props: {
    to: {
      type: String,
      required: true,
    },
  },
  methods: {
    type(url) {
      if (isExternal(url)) {
        return "a";
      }
      return "router-link";
    },
    linkProps(url) {
      if (isExternal(url)) {
        return {
          href: url,
          target: "_blank",
          rel: "noopener",
        };
      }
      return {
        to: url,
      };
    },
  },
};
</script>
