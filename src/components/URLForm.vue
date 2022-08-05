<template>
  <form @submit.prevent="handleSubmit">
    <div
      class="flex rounded hover:shadow-xl duration-100 transition-shadow bg-slate-700 shadow-lg focus-within:ring-2"
    >
      <URLFormProtocol v-model="protocol" class="w-20 md:w-32"></URLFormProtocol>
      <input
        type="text"
        name="url"
        v-model="urlInput"
        placeholder="Enter URL here"
        class="focus:outline-none bg-transparent text-white bg-slate-700 flex-grow px-4 rounded-r"
      />
    </div>

    <button
      type="submit"
      class="grid place-content-center mx-auto bg-blue-400 hover:bg-blue-200 mt-8 w-32 py-2 rounded"
      :class="{ 'opacity-50 pointer-events-none': !urlInput }"
    >
      <span
        v-if="isLoading"
        class="col-start-1 row-start-1 w-4 h-4 border-2 rounded-full border-slate-800 border-b-transparent animate-spin my-1"
      ></span>
      <span class="col-start-1 row-start-1 text-slate-800 font-bold" v-else
        >Go</span
      >
    </button>
  </form>
</template>

<script lang="ts" setup>
import { ref } from "vue";
import URLFormProtocol from "./URLFormProtocol.vue";

defineProps({
  isLoading: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits<(e: "submit", d: string) => void>();

const protocol = ref<"http" | "https">("https");
const urlInput = ref("");

const handleSubmit = () => {
  if (urlInput.value) emit("submit", `${protocol.value}://${urlInput.value}`);
};
</script>
