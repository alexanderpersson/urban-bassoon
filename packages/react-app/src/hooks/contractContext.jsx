import { createContext, useContext } from "react";

const ctx = createContext(undefined)

export const useContract = () => useContext(ctx)

export const ContractContextProvider = ({ children, ...props }) => {

    return <ctx.Provider value={{
        ...props
    }}>{children}</ctx.Provider>
}