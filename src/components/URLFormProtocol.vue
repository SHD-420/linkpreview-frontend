<template>
  <div class="relative" ref="parentEl">
    <button
      type="button"
      @click="shouldShowDropdown = !shouldShowDropdown"
      class="py-2 bg-slate-900 text-gray-500 hover:bg-slate-800 w-full rounded-l"
    >
      {{ modelValue }}://
    </button>
    <transition name="slide-y">
      <ul
        v-if="shouldShowDropdown"
        class="absolute bg-slate-900 rounded w-full mt-1 divide-y divide-slate-800"
      >
        <li>
          <button
            type="button"
            class="text-gray-300 p-2 w-full text-left hover:bg-slate-800 hover:shadow-lg"
            @click="selectValue('http')"
          >
            http
          </button>
        </li>
        <li>
          <button
            type="button"
            class="text-gray-300 p-2 w-full text-left hover:bg-slate-800 hover:shadow-lg"
            @click="selectValue('https')"
          >
            https
          </button>
        </li>
      </ul>
    </transition>
  </div>
</template>

<script lang="ts" setup>
import { PropType, ref } from "vue";

const props = defineProps({
  modelValue: {
    type: String as PropType<"http" | "https">,
    default: "https",
  },
});
const emit =
  defineEmits<(e: "update:modelValue", d: typeof props.modelValue) => void>();

const shouldShowDropdown = ref(false);

const selectValue = (val: typeof props.modelValue) => {
  emit("update:modelValue", val);
  shouldShowDropdown.value = false;
};

// Close the dropdown if any other element is clicked
const parentEl = ref<HTMLElement>();
window.addEventListener("click", (ev) => {
  if (
    shouldShowDropdown.value &&
    !ev.composedPath().includes(parentEl.value as EventTarget)
  ) {
    shouldShowDropdown.value = false;
  }
});
</script>

<style scoped>
.slide-y-enter-active,
.slide-y-leave-active {
  @apply duration-300 ease-out;
}
.slide-y-enter-from {
  @apply -translate-y-4 opacity-0;
}

.slide-y-leave-to{
  @apply opacity-0;
}
</style>
