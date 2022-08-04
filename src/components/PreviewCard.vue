<template>
  <div class="py-8 px-4 rounded shadow-xl bg-slate-900">
    <div class="max-w-xl mx-auto">
      <h5 class="text-gray-500 truncate mb-4">
        Showing result for <span class="font-semibold">"{{ url }}"</span>
      </h5>
      <div class="flex">
        <img
          class="w-8 h-8 object-cover block mr-4 mt-2"
          :src="faviconURL"
          v-show="isFaviconLoaded"
          @error="handleImageLoadError"
          @load="isFaviconLoaded = true"
        />
        <div>
          <p class="text-gray-500">
            <span>Status code:</span>
            <span class="font-bold ml-2">{{ data.status }}</span>
          </p>
          <h4 class="text-2xl text-white mb-2">{{ data.title }}</h4>
          <p class="text-gray-500 italic" v-if="!data.description">
            No description could be found.
          </p>
          <p class="text-gray-300" v-else>{{ data.description }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { PropType, ref } from "vue";
import type { LinkPreview } from "../types.js";

const props = defineProps({
  data: {
    type: Object as PropType<LinkPreview>,
    required: true,
  },
  url: {
    type: String,
    required: true,
  },
});

// Fetch the first possible icon from 1: origin/favicon.ico or 2: any link from data.favicons array
let currentFaviconIndex = -1;
const faviconURL = ref(`${new URL(props.url).origin}/favicon.ico`);
const handleImageLoadError = () => {
  if (currentFaviconIndex < props.data.favicons.length) {
    currentFaviconIndex++;
    faviconURL.value = props.data.favicons[currentFaviconIndex];
  }
};

const isFaviconLoaded = ref(false);
</script>
