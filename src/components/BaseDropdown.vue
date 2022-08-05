<template>
  <div class="relative" ref="parentEl">
    <slot
      name="button"
      :handleClick="
        () => {
          shouldShowDropdown = !shouldShowDropdown;
        }
      "
    >
    </slot>
    <transition name="slide-y">
      <div class="absolute w-full" v-if="shouldShowDropdown" @click="shouldShowDropdown=false">
        <slot
          name="dropdown"
          :hide="
            () => {
              shouldShowDropdown = false;
            }
          "
        ></slot>
      </div>
    </transition>
  </div>
</template>

<script lang="ts" setup>
import { ref } from "vue";

const shouldShowDropdown = ref(false);

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

.slide-y-leave-to {
  @apply opacity-0;
}
</style>
