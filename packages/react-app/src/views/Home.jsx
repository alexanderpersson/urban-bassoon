import { useContractReader } from "eth-hooks";
import { useEffect, useState } from "react";
import { useContract } from "../hooks/contractContext"
import styled from 'styled-components'
import classNames from 'classnames'
export default () => {
  const {
    tx,
    writeContracts,
    readContracts,

  } = useContract()
  // const purpose = useContractReader(readContracts, "YourContract", "purpose");

  const [numbers, setNumbers] = useState([])
  const [winner, setWinner] = useState()

  useEffect(() => {
    read()
  }, [readContracts])

  const read = async () => {
    if (!readContracts.YourContract) return

    let result = await tx(readContracts.YourContract.getNumbers())
    let winner = await tx(readContracts.YourContract.getWinner())
    console.log('winner', winner)
    setWinner(winner)
    setNumbers(result.map(x => parseInt(x.toString())))
  }

  const participate = async (val) => {
    await tx(writeContracts.YourContract.participate(val))
    read()
  }

  const draw = async () => {
    let winningNumber = await tx(writeContracts.YourContract.draw())
    
    read()
  }

  return <>

    Winner: {winner && <pre>{JSON.stringify(winner, null, 2)}</pre>}

    <GridContainer>
      {Array.from(Array(9).keys()).map(x => x + 1).map(x => <Number className={classNames({ taken: numbers.indexOf(x) > -1 })} onClick={() => participate(x)} key={x}>{x}</Number>)}
    </GridContainer>
    <button onClick={draw}>draw winner</button>

  </>
}


const GridContainer = styled.div`
  display: grid;
  grid-template-columns: auto auto auto;
  background-color: #2196F3;
  padding: 10px;
`
const Number = styled.button`
  background-color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.8);
  padding: 20px;
  font-size: 30px;
  text-align: center;

  &.taken {
   background-color:red;
  }
`
