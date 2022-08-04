<template>
  <div class="min-h-screen bg-slate-800">
    <div class="py-8 px-2 md:w-8/12 mx-auto">
      <AppHead></AppHead>
      <URLForm @submit="getPreview" :is-loading="isLoading"></URLForm>
      <div class="mt-16">
        <transition name="slide-y" mode="out-in">
          <div
            v-if="isLoading"
            class="py-8 px-4 bg-slate-900 rounded text-gray-500"
          >
            <p class="text-center">Fetching your preview...</p>
          </div>
          <div
            v-else-if="hasError"
            class="py-8 px-4 bg-slate-900 border-2 border-red-500 rounded text-red-500"
          >
            <p class="text-center">
              Error! Please make sure that resource "{{ currentURL }}" exists
              and requires no authorization.
            </p>
          </div>
          <PreviewCard
            :key="currentURL"
            v-else-if="currentPreview && currentURL"
            :data="currentPreview"
            :url="currentURL"
          ></PreviewCard>
        </transition>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import type { LinkPreview } from "./types";
import AppHead from "./components/AppHead.vue";
import URLForm from "./components/URLForm.vue";
import PreviewCard from "./components/PreviewCard.vue";

const isLoading = ref(false);
const currentURL = ref<string>();
const currentPreview = ref<LinkPreview>();
const hasError = ref(false);

const getPreview = (url: string) => {
  if (!isLoading.value && url !== currentURL.value) {
    delete currentPreview.value;
    hasError.value = false;
    currentURL.value = url;
    isLoading.value = true;
    fetch("/api/get-preview", {
      method: "post",
      body: JSON.stringify({ link: url }),
    })
      .then((res) => {
        if (res.status === 200) return res.json();
        else hasError.value = true;
      })
      .then((data) => {
        currentPreview.value = data as LinkPreview;
      })
      .finally(() => (isLoading.value = false));
  }
};
</script>

<style scoped>
.slide-y-enter-active,
.slide-y-leave-active {
  @apply duration-200 ease-out;
}
.slide-y-enter-from,
.slide-y-leave-to {
  @apply translate-y-4 opacity-0;
}
</style>

