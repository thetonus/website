import rss from "@astrojs/rss";
import getPostData from "../../utils/getPostData";

const postImportResult = import.meta.glob("../../../content/blog/*.md", {
  eager: true,
});
// Sort in descending order
const posts = Object.values(postImportResult).sort(
  (a, b) =>
    new Date(b.frontmatter.publishDate).valueOf() -
    new Date(a.frontmatter.publishDate).valueOf()
);

export const get = () =>
  rss({
    title: "Tony Hammack’s Blog",
    description: "A place for my thoughts...",
    site: import.meta.env.SITE,
    items: posts.map((post) => {
      const { slug } = getPostData(post);
      return {
        link: `posts/${slug}`, // rss module injects the SITE, only needs to work on the path
        title: post.frontmatter.title,
        pubDate: post.frontmatter.publishDate,
      };
    }),
    customData: `<language>en-us</language>`,
  });
