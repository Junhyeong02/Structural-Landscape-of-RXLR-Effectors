import os
import json
import subprocess
from multiprocessing import Pool, cpu_count
from glob import glob

def run_tmalign_and_parse(pdb1, pdb2):
    command = f"./TMalign {pdb1} {pdb2} -outfmt 2"
    
    try:
        # subprocess.run으로 TMalign 실행 및 결과 캡처
        result = subprocess.run(command, shell=True, text=True, capture_output=True, check=True)
        output = result.stdout

        data = output.split("\n")[1].split()
        TM1 = data[2]
        TM2 = data[3]
        rmsd = data[4]
        aligned_length = data[-1]
        
        protein1 = os.path.basename(pdb1).replace(".pdb", "")
        protein2 = os.path.basename(pdb2).replace(".pdb", "")
        
        return {
            "1": protein1,
            "2": protein2,
            "tm1": TM1,
            "tm2": TM2,
            "rmsd": rmsd,
            "al": aligned_length,
        }
        
    except subprocess.CalledProcessError as e:
        print(f"Error running TMalign for {pdb1} and {pdb2}: {e}")
        return {
            "1": protein1,
            "2": protein2,
        }


# 실행
if __name__ == "__main__":
    protein_pairs = []

    pdb = glob("../wy_pdb/*.pdb")
    print("Number of proteins:", len(pdb))
    
    for p1 in pdb:
        for p2 in pdb:
            protein_pairs.append((p1, p2))

    print("Number of pairs:", len(protein_pairs))
    
    with Pool(processes=72) as pool: 
        results = pool.starmap(run_tmalign_and_parse, protein_pairs)

    data = {"results": results}

    print("Number of results:", len(results))

    with open("RXLR_WY_tmscore.json", "w") as f:
        json.dump(data, f)
    