<script setup lang="ts">
import InitialAvatar from "@/ui/components/InitialAvatar.vue";
import { UserWithIdType } from "@/models/userWithId.type";
import router from "@/router/router";
import { usersService } from "@/services/users.service";
import { ref, onMounted } from "vue";

const profile = () => {
  router.push("/dashboard/profile");
};

// Declare a reactive reference `user` with an initial value of null.
// The type of `user` is either `UserWithIdType` or `null`
let user = ref<UserWithIdType | null>(null);

// Define an asynchronous function `fetchUser`.
const fetchUser = async () => {
  // Try to fetch the current user using the token.
  try {
    const fetchedUser = await usersService.getCurrentUser();
    user.value = fetchedUser;
  } catch (e) {
    console.error("Error fetching user:", e);
  }
};

onMounted(fetchUser);
</script>

<template>
  <article
    @click="profile"
    class="user-card__container logged_user_card selection-cursor"
  >
    <figure class="user-card__avatar">
      <InitialAvatar
        :firstname="user?.firstname || ''"
        :lastname="user?.lastname || ''"
      />
    </figure>
    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">{{ user?.firstname }} {{ user?.lastname }}</p>
      <p class="user-card__info-text">{{ $t("connectedUserCard.role") }}</p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.selection-cursor {
  cursor: pointer;
}
</style>
