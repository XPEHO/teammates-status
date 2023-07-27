import { defineStore } from "pinia";

import { loginService } from "@/services/login.service";
import { captainService } from "@/services/captain.service";
import { customerService } from "@/services/customer.service";

import router from "@/router/router";

import { useTeamStore } from "@/stores/teamStore.js";
import { useCustomerRightsStore } from "@/stores/customerRightsStore.js";

import { CustomersRightsType } from "@/models/customersRights.type";
import { CaptainType } from "@/models/captain.type";

export const useAuthStore = defineStore("loginStore", {
  state: () => ({
    captains: [] as CaptainType[],
    customersRights: [] as CustomersRightsType[],
    user: (() => {
      const userString = localStorage.getItem("user");
      return userString ? JSON.parse(userString) : "";
    })(),
    returnedUrl: null as string | null,
  }),
  actions: {
    async login(login: string, password: string): Promise<boolean> {
      try {
        localStorage.setItem("user", JSON.stringify(this.user));
        this.user = await loginService.login(login, password);
        this.captains = await captainService.getAllCaptainByUserId(
          this.user.id
        );
        this.customersRights = await customerService.getAllCustomersRightById(
          this.user.id
        );
        //if the user is not a captain or a customer, he can't access to the admin part
        if (this.customersRights.length === 0 && this.captains.length === 0) {
          console.log("not captain or customer");
          this.logout();
          return false;
        }
        let idsCust = [];
        let idsCap = [];
        for (const customerRights of this.customersRights) {
          idsCust.push(customerRights.id);
        }
        for (const captain of this.captains) {
          idsCap.push(captain.id);
        }
        const teamStore = useTeamStore();
        const customerRightsStore = useCustomerRightsStore();
        teamStore.setCaptainsId(idsCap);
        customerRightsStore.setCustomersRightsId(idsCust);
        router.push(
          this.returnedUrl ||
            "/administration/captain" ||
            "/administration/customer"
        );
        return true;
      } catch {
        return false;
      }
    },
    logout() {
      this.user = null;
      localStorage.removeItem("user");
      router.push("/");
    },
  },
});
