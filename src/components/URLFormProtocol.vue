<template>
  <BaseDropdown>
    <template #button="{ handleClick }">
      <button
        type="button"
        @click="handleClick"
        class="py-2 bg-slate-900 text-gray-500 hover:bg-slate-800 w-full rounded-l"
      >
        {{ modelValue }}://
      </button>
    </template>
    <template #dropdown="{ hide }">
      <ul
        class="absolute bg-slate-900 rounded w-full mt-1 divide-y divide-slate-800"
      >
        <li>
          <button
            type="button"
            class="text-gray-300 p-2 w-full text-left hover:bg-slate-800 hover:shadow-lg"
            @click="selectValue(hide, 'http')"
          >
            http
          </button>
        </li>
        <li>
          <button
            type="button"
            class="text-gray-300 p-2 w-full text-left hover:bg-slate-800 hover:shadow-lg"
            @click="selectValue(hide, 'https')"
          >
            https
          </button>
        </li>
      </ul>
    </template>
  </BaseDropdown>
</template>

<script lang="ts" setup>
import { PropType } from "vue";
import BaseDropdown from "./BaseDropdown.vue";

const props = defineProps({
  modelValue: {
    type: String as PropType<"http" | "https">,
    default: "https",
  },
});
const emit =
  defineEmits<(e: "update:modelValue", d: typeof props.modelValue) => void>();

const selectValue = (
  hideDropdown: () => void,
  val: typeof props.modelValue
) => {
  hideDropdown();
  emit("update:modelValue", val);
};
</script>
