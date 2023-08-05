import { defineConfig } from "astro/config";
import svelte from "@astrojs/svelte";
import mdx from "@astrojs/mdx";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

// https://astro.build/config
export default defineConfig({
  output: "static",
  site: "https://theoraclenetwork.com",
  integrations: [mdx(), tailwind(), svelte(), sitemap()],
  markdown: {
    shikiConfig: {
      theme: "dark-plus",
    },
  },
});
