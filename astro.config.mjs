import { defineConfig } from "astro/config";
import svelte from "@astrojs/svelte";
import mdx from "@astrojs/mdx";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

// https://astro.build/config

// https://astro.build/config
export default defineConfig({
  site: "https://theoraclenetwork.com",
  integrations: [tailwind(), mdx(), svelte(), sitemap()],
  markdown: {
    shikiConfig: {
      theme: "nord"
    },
    rehypePlugins: [["rehype-external-links", {
      target: "_blank"
    }]]
  }
});