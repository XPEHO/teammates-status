import { defineStore } from "pinia";

import { loginService } from "@/services/login.service";
import { captainService } from "@/services/captain.service";
import { customerService } from "@/services/customer.service";

import router from "@/router/router";

import { useTeamStore } from "@/stores/teamStore.js";
import { useCustomerRightsStore } from "@/stores/customerRightsStore.js";

import { CaptainType } from "@/models/captain.type";
import { CustomerType } from "@/models/customer.type";

export const useAuthStore = defineStore("loginStore", {
  state: () => ({
    captains: [] as CaptainType[],
    customersRights: [] as CustomerType[],
    user: (() => {
      const userString = localStorage.getItem("user");
      return userString ? JSON.parse(userString) : "";
    })(),
    returnedUrl: null as string | null,
  }),
  actions: {
    async login(login: string, password: string): Promise<boolean> {
      try {
        this.user = await loginService.login(login,password);
        localStorage.setItem('user', JSON.stringify(this.user));
        this.captains = await captainService.getAllCaptainByUserId(
          this.user.id
        );
        this.customersRights =
          await customerService.getAllCustomersRightByUserId(this.user.id);
        //if the user is not a captain or a customer, he can't access to the admin part
        if (this.customersRights.length === 0 && this.captains.length === 0) {
          this.logout();
          return false;
        }
        const teamStore = useTeamStore();
        const customerRightsStore = useCustomerRightsStore();
        //in what route the user will be redirect depending of his rights.
        if (this.customersRights.length >= 1) {
          this.returnedUrl = "/customer/manage-captain";
        } else {
          //if not a customer it's necessarily a captain
          this.returnedUrl = "/administration/captain";
          teamStore.setCustomerId(this.captains[0].customerId)
        }
        
        
        let idsCust = [];
        let idsCap = [];
        for (const customerRights of this.customersRights) {
          idsCust.push(customerRights.id);
        }
        for (const captain of this.captains) {
          idsCap.push(captain.id);
        }
        
        //temporary we must choose the customer then.
        
        teamStore.setCaptainsId(idsCap);
        customerRightsStore.setCustomersRightsId(idsCust);

        router.push(this.returnedUrl);
        return true;
        
        
        
        //
        
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
