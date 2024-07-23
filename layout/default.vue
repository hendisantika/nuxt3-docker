<template>
  <div>
    <header>
      <div>
        <NuxtLink to="/">Home</NuxtLink>
      </div>
      <div>
        <NuxtLink to="/page1">Page 1</NuxtLink>
      </div>
      <div>
        <NuxtLink to="/page2">Page 2</NuxtLink>
      </div>
    </header>
    <content>
      <slot/>
    </content>
  </div>
</template>

<style>
header {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 12px;
  height: 40px;
  border: 1px solid #eee;
  padding: 8px;
}

header a {
  text-decoration: none;
}

content {
  display: flex;
  padding: 8px;
}
</style>