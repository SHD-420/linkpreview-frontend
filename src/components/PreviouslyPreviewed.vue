<template>
  <div class="mb-4 z-10 relative">
    <BaseDropdown>
      <template #button="{ handleClick }">
        <button
          @click="handleClick"
          class="text-sm text-gray-300 bg-slate-700 px-4 py-1 rounded-full hover:bg-slate-900"
          :class="{ 'pointer-events-none opacity-50': !items.size }"
        >
          Prevously previewed &#9662;
        </button>
      </template>
      <template #dropdown="{ hide }">
        <ul
          class="bg-slate-900 rounded w-full mt-1 divide-y divide-slate-800 shadow-xl max-w-xs absolute"
        >
          <li v-for="(item, index) in items" :key="index">
            <button
              @click="
                hide();
                emit('preview-requested', item.url);
              "
              class="px-4 py-2 hover:bg-slate-800 hover:shadow-lg w-full text-left"
            >
              <p class="text-gray-300 truncate">
                {{ item.title }}
              </p>
              <p class="text-sm text-gray-500 truncate">
                {{ item.url }}
              </p>
            </button>
          </li>
        </ul>
      </template>
    </BaseDropdown>
  </div>
</template>

<script lang="ts" setup>
import { PropType, ref, watch } from "vue";
import type { PreviewHistoryItem } from "../types";
import BaseDropdown from "./BaseDropdown.vue";

const props = defineProps({
  currentItem: {
    type: Object as PropType<PreviewHistoryItem | null>,
    default: null,
  },
});

const emit = defineEmits<(e: "preview-requested", d: string) => void>();

const items = ref<Set<PreviewHistoryItem>>(new Set());

const storageKey = "history";
const loadHistory = () => {
  try {
    const localHistory = JSON.parse(localStorage.getItem(storageKey) || "");
    if (Array.isArray(localHistory) && localHistory.length <= 5) {
      items.value = new Set(localHistory as PreviewHistoryItem[]);
    }
  } catch (error) {
    if (error instanceof SyntaxError) {
      items.value = new Set([]);
      localStorage.setItem(storageKey, JSON.stringify([]));
    }
  }
};

loadHistory();

const saveToHistory = (item: PreviewHistoryItem) => {
  // Ensure uniqueness in items
  let itemsArr = Array.from(items.value);
  const sameItemIndex = itemsArr.findIndex((i) => i.url === item.url);
  if (sameItemIndex !== -1)
    itemsArr = [
      ...itemsArr.slice(0, sameItemIndex),
      ...itemsArr.slice(sameItemIndex + 1),
    ];
  itemsArr = [item, ...itemsArr].slice(0, 5);

  items.value = new Set(itemsArr);
  localStorage.setItem(storageKey, JSON.stringify(itemsArr));
};

watch(
  () => props.currentItem,
  (newVal) => {
    if (newVal) saveToHistory(newVal);
  }
);
</script>
