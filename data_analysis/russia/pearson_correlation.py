import os
import pandas as pd
from itertools import combinations

# --- Utilidad para cargar cada CSV ruso de keyword ---
def cargar_csv_keyword(filepath):
    # Read with ; as separator and only grab the first two cols
    df = pd.read_csv(filepath, sep=';', usecols=[0,1], names=['Период', 'Число запросов'], skiprows=1,
                     encoding='utf-8')
    # Clean thousands separator
    df['Число запросов'] = df['Число запросов'].astype(str).str.replace(' ', '').astype(float)
    return df

# --- Lee todos los CSVs de keywords en este directorio ---
def cargar_todos_keywords(dirpath):
    series = {}
    for f in os.listdir(dirpath):
        if not f.endswith('.csv') or f == 'keyword_list.csv':
            continue
        kw = f.replace('.csv','')
        try:
            df = cargar_csv_keyword(os.path.join(dirpath, f))
            series[kw] = df['Число запросов'].reset_index(drop=True)
        except Exception as ex:
            print(f"[Aviso] No se pudo leer {f}: {ex}")
    return pd.DataFrame(series)

# --- PROGRAMA PRINCIPAL ---
def main():
    directorio = os.path.dirname(os.path.abspath(__file__))
    df_trends = cargar_todos_keywords(directorio)
    # Remove empty columns
    df_trends = df_trends.loc[:, df_trends.notna().any()]
    # Pearson correlation matrix
    matriz_corr = df_trends.corr(method='pearson')
    print('Matriz de correlación de Pearson:\n', matriz_corr, '\n')

    # Load last month traffic data
    dict_trafico = {}
    kwlist_path = os.path.join(directorio, 'keyword_list.csv')
    with open(kwlist_path, encoding='utf-8') as kwf:
        next(kwf)
        for linea in kwf:
            partes = linea.strip().split(',')
            if len(partes) != 2: continue
            k,v = partes
            try:
                dict_trafico[k] = int(v)
            except:
                continue
    keywords_comunes = sorted(set(dict_trafico).intersection(df_trends.columns))
    if not keywords_comunes:
        print('¡ERROR! No hay keywords comunes entre los CSV y el archivo de lista.')
        return
    print('Keywords usadas para el cálculo:', keywords_comunes, '\n')
    trafico_total = sum(dict_trafico[k] for k in keywords_comunes)
    # Overlap adjustment: only very strong positive Pearson correlations (e.g. > 0.95)
    ajuste = 0.0
    for kw1, kw2 in combinations(keywords_comunes, 2):
        correlacion = matriz_corr.loc[kw1, kw2]
        # Only very strong positive correlation means meaningful overlap
        if correlacion > 0.95:
            minimo = min(dict_trafico[kw1], dict_trafico[kw2])
            ajuste += correlacion * minimo
    # Never allow more than total traffic to be subtracted
    ajuste = min(ajuste, trafico_total)
    trafico_ajustado = trafico_total - ajuste
    print(f'Tráfico total simple (suma): {trafico_total}')
    print(f"Ajuste correlacional (solo correlaciones > 0.95, limitado al tráfico total): {ajuste:.2f}")
    print(f'Tráfico estimado ajustado: {trafico_ajustado:.2f}')

if __name__ == "__main__":
    main()
